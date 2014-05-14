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

end
