# local_sitemap.txt-creator
Creates a sitemap.txt from the local file system

A simple perl script that will create a sitemap.txt from the .htm and .html files in the local directory and below. 

Recurses through current directory and below. When it finds a .htm or .html file, adds them to sitemap.txt on the top directory, preceeding each with https://domain/

Designed for websites you've created locally. It does no remote fetching so is very fast. 

Can be uploaded to Google Search Console.

Has no includes or dependencies, should be very portable and run on any system running a version of perl from the last 2 or so decades.

# Usage (don't forget trailing slash)

Download or copy and paste the script locally and chmod +x. 

create_sitemap.pl https://my.domain.com/

# Example output in sitemap.txt created with: create_sitemap.pl https://dartmoorcam.co.uk/

```
https://dartmoorcam.co.uk/CAM/copyright.htm
https://dartmoorcam.co.uk/CAM/cornwall/cornwall.htm
https://dartmoorcam.co.uk/CAM/sitemap.htm
https://dartmoorcam.co.uk/CAM/OrdnanceSurveyLicenceTermsAndConditions.htm
https://dartmoorcam.co.uk/CAM/CarParks/OkehamptonStationTeaRoomMenu.htm
```
