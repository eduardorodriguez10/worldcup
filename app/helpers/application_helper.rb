module ApplicationHelper
	def get_icon(score)
		if (score == 0)
			"glyphicon-remove-circle"
		elsif (score == 1)
			'glyphicon-adjust'
		elsif (score == 2)
			'glyphicon-ok-circle'
		else
			"glyphicon-question-sign"
		end
	end
  def points_full
    2
  end
  def points_half
    1
  end
  def points_wrong
    0
  end
  def points_undefined
    -1
  end
	def update_selections
    Team.all.each do |t|
      t.r16_selections = 0
      t.quaterfinals_selections = 0
      t.semifinals_selections = 0 
      t.final_selections = 0 
      t.third_match_selections = 0
      t.champion_selections = 0
      t.third_selections = 0
      t.save
    end
    Bracket.all.each do |b|
      for i in 97..104
          for x in 1..2
            t = Team.find_by(id: b.send(i.chr+x.to_s))
            if(!t.nil?)
              t.r16_selections +=1
              t.save
            end
          end
      end
      for i in 49..56
          t = Team.find_by(id: b.send('w'+i.to_s))
          if(!t.nil?)
            t.quaterfinals_selections +=1
            t.save
          end
      end
      for i in 57..60
          t = Team.find_by(id: b.send('w'+i.to_s))
          if(!t.nil?)
            t.semifinals_selections +=1
            t.save
          end
      end
      for i in 61..62
          t = Team.find_by(id: b.send('w'+i.to_s))
          if(!t.nil?)
            t.final_selections +=1
            t.save
          end
      end
      for i in 61..62
          t = Team.find_by(id: b.send('l'+i.to_s))
          if(!t.nil?)
            t.third_match_selections +=1
            t.save
          end
      end
      t = Team.find_by(id: b.third)
        if(!t.nil?)
            t.third_selections +=1
            t.save
        end
      t = Team.find_by(id: b.champion)
        if(!t.nil?)
            t.champion_selections +=1
            t.save
        end
    end
  end

  def update_all_scores
    Bracket.all.each do |b|
      count_full_r16 = 0
      count_half_r16 = 0
      count_quaterfinals = 0
      count_semifinals = 0
      count_final = 0
      count_third_match = 0
      count_third_place = 0
      count_champion = 0 
      b.score = 0
      for i in 97..104
          for x in 1..2
            t = Team.find_by(id: b.send(i.chr+x.to_s))
            if(!t.nil?)
              if(t.r16_defined)
                if(t.r16_madeit)
                  if(t.r16_position == (i.chr+x.to_s))
                      b[i.chr+x.to_s+'s'] = points_full
                      b.score += points_full
                      count_full_r16 += 1
                  else
                      b[i.chr+x.to_s+'s'] = points_half
                      b.score += points_half
                      count_half_r16 += 1
                  end
                else
                  b[i.chr+x.to_s+'s'] = points_wrong
                  b.score += points_wrong
                end
              else 
                b[i.chr+x.to_s+'s'] = points_undefined 
              end
            end
          end
      end
      b.full_r16 = count_full_r16
      b.half_r16 = count_half_r16
      for i in 49..56
          t = Team.find_by(id: b.send('w'+i.to_s))
          if(!t.nil?)
            if(t.quaterfinals_defined)
              if(t.quaterfinals_madeit)
                if(t.quaterfinals_position == ('w'+i.to_s))
                  b['w'+i.to_s+'s'] = points_full
                  b.score += points_full
                  count_quaterfinals += 1
                else
                  b['w'+i.to_s+'s'] = points_full
                  b.score += points_full
                  count_quaterfinals += 1
                end
              else
                  b['w'+i.to_s+'s'] = points_wrong
                  b.score += points_wrong
              end
            else
              b['w'+i.to_s+'s'] = points_undefined
            end
          end
      end
      b.full_quaterfinals = count_quaterfinals
      for i in 57..60
          t = Team.find_by(id: b.send('w'+i.to_s))
          if(!t.nil?)
            if(t.semifinals_defined)
              if(t.semifinals_madeit)
                if(t.semifinals_position == ('w'+i.to_s))
                  b['w'+i.to_s+'s'] = points_full
                  b.score += points_full
                  count_semifinals += 1
                else
                  b['w'+i.to_s+'s'] = points_full
                  b.score += points_full
                  count_semifinals += 1
                end
              else
                  b['w'+i.to_s+'s'] = points_wrong
                  b.score += points_wrong
              end
            else
              b['w'+i.to_s+'s'] = points_undefined
            end
          end
      end
      b.full_semifinals = count_semifinals
      for i in 61..62
          t = Team.find_by(id: b.send('w'+i.to_s))
          if(!t.nil?)
            if(t.final_defined)
              if(t.final_madeit)
                b['w'+i.to_s+'s'] = points_full
                b.score += points_full
                count_final += 1
              else
                b['w'+i.to_s+'s'] = points_wrong
                b.score += points_wrong
              end
            else
              b['w'+i.to_s+'s'] = points_undefined
            end
          end
      end
      for i in 61..62
          t = Team.find_by(id: b.send('l'+i.to_s))
          if(!t.nil?)
            if(t.third_match_defined)
              if(t.third_match_madeit)
                b['l'+i.to_s+'s'] = points_full
                b.score += points_full
                count_third_match += 1
              else
                b['l'+i.to_s+'s'] = points_wrong
                b.score += points_wrong
              end
            else
              b['l'+i.to_s+'s'] = points_undefined
            end
          end
      end
      t = Team.find_by(id: b.third)
         if(!t.nil?)
            if(t.third_place_defined)
              if(t.third_place_madeit)
                b['thirds'] = points_full
                b.score += points_full
                count_third_place += 1
              else
                b['thirds'] = points_wrong
                b.score += points_wrong
              end
            else
              b['thirds'] = points_undefined
            end
          end
      t = Team.find_by(id: b.champion)
        if(!t.nil?)
            if(t.champion_defined)
              if(t.champion_madeit)
                b['champions'] = points_full
                b.score += points_full
                count_champion += 1
              else
                b['champions'] = points_wrong
                b.score += points_wrong
              end
            else
              b['champions'] = points_undefined
            end
        end
        b.full_total = count_full_r16 + count_quaterfinals + count_semifinals + count_final + count_third_match + count_champion + count_third_place
        b.half_total = count_half_r16
        b.save
    end  
  end

  def update_all_memberships 
    Membership.all.each do |m|
      bracket = Bracket.find_by(user_id: m.user_id)
      if(!bracket.nil?)
        m.full_r16 = bracket.full_r16
        m.half_r16 = bracket.half_r16
        m.full_quaterfinals = bracket.full_quaterfinals
        m.full_semifinals = bracket.full_semifinals
        m.full_total = bracket.full_total
        m.half_total = bracket.half_total 
        m.score = bracket.score
        m.save
      end
    end
  end
end
