package HTML_Header_Commons is
   
   type Library_Type is ( css, javascript, font );

   --
   -- these are from dublin core; see: http://en.wikipedia.org/wiki/Dublin_Core.
   -- 
   type Dublin_Core_Type is (
      title,
      creator,
      subject,
      description,
      publisher,
      contributor,
      date,
      content_type,
      format,
      identifier,
      source,
      language,
      relation,
      coverage,
      rights );

    
   type Open_Graph_Base_Type is (
      activity,
      sport,

      bar,
      company,
      cafe,
      hotel,
      restaurant,

      cause,
      sports_league,
      sports_team,

      band,
      government,
      non_profit,
      school,
      university,

      actor,
      athlete,
      author,
      director,
      musician,
      politician,
      profile,
      public_figure,
      
      city,
      country,
      landmark,
      state_province,
      
      album,
      book,
      drink,
      food,
      game,
      movie,
      product,
      song,
      tv_show,

   -- For products which have a UPC code or ISBN number, you can specify them using the og:upc and og:isbn properties. These properties help to make more concrete connections between graphs.
       article,
       blog,
       website );
   
   subtype Activities_Type is Open_Graph_Base_Type range activity .. sport;     
   subtype Business_Type is Open_Graph_Base_Type range bar .. restaurant;     
   subtype Group_Type is Open_Graph_Base_Type range cause .. sports_team;     
   subtype People_Type is Open_Graph_Base_Type range actor .. public_figure;
   subtype Place_Type is Open_Graph_Base_Type range city .. state_province;
   subtype Product_Type is Open_Graph_Base_Type range album .. tv_show;
   subtype Website_Type is Open_Graph_Base_Type range article .. website;
   
end HTML_Header_Commons;
