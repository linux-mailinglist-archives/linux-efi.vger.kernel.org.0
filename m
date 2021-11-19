Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5167C4571F5
	for <lists+linux-efi@lfdr.de>; Fri, 19 Nov 2021 16:45:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235718AbhKSPsh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 19 Nov 2021 10:48:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbhKSPsh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 19 Nov 2021 10:48:37 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2FEC061574;
        Fri, 19 Nov 2021 07:45:35 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id t26so45033463lfk.9;
        Fri, 19 Nov 2021 07:45:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=H5DNf1Om0RwN3xbCK02EXPW+4a49S0Mj+o5dz3hW1Ao=;
        b=jgFeD6KHlr8fc/qBe69bLZyZid40UQIXlYu7QjNSAPKFWeThwOkK4rw8SW6nGU2HC7
         h41Bl2nc6bcd8VFm2tQQcIKDiXWjJP1Fj6ulg9ECJUCjd36QqSTJHWZtRSsEypg0TYmo
         9RqE2KiPJzlGYTLvOvFmX/TwtHR5kCbnpJf3pyZ415bwlWXWWWB4CAmQNEanSEdCtwnp
         w1GaDfnicEFtO/Bo8PBdVm6rHJ33iuUweSY3h43xaQTM66GmoArVXJaK36ipyVX6sInZ
         nyhls+omGqpGE2oID+XT1IPMzcG+nu8mBdqPCZ2FwgtJO/2Y20LuPZ20fEI10gWdpWai
         ZYgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=H5DNf1Om0RwN3xbCK02EXPW+4a49S0Mj+o5dz3hW1Ao=;
        b=RRP51P4pzkkCw2OAZPHDSZuqA59EUAhGMRg85AHaXRr6CtLTBwaDqPQQtAF80undp6
         SnHZThlCZCLEVOoRAOyjc0pSyp+MYxu1vgRq92Pb6OXRdCqegwfqIM+igY1VxfWreDim
         F6MiQa+eex08JpDrThIJ7UmJTFHuZYSMuEvEuYkPUet1NlHbGUWaX9wVz6Q5TsB9xmiS
         c9wLG97yRCZm7FVX/4fhvn6n/6tbXJghWsXPHs4oqKfgBYBK4sO+W9U6LNz8Sg7uNcgb
         asxzp15gjd9L4lg+/7XyqSnSwwK1Y0P6Pz6AOzgCVmwCeb3C2lSgRi6LBf7rP2ch7X4Y
         gpEw==
X-Gm-Message-State: AOAM5315cGPt8AjYiEhAWxUr5E6DpUl3hhF/0JdXFdJHNAafFezj3hHq
        xQ9U2AbfwTcSW2IgmV642H6nq7ASsKlI5h2mkiI=
X-Google-Smtp-Source: ABdhPJw3+LsGrV6BE/PJnSU0eWWwjMN//P6rVmixx+B5xJdk+hOh+foW7PN1rErwhpVqxuHtpaiySXy/VuoVMi3TPlc=
X-Received: by 2002:a05:6512:114a:: with SMTP id m10mr34357387lfg.188.1637336733476;
 Fri, 19 Nov 2021 07:45:33 -0800 (PST)
MIME-Version: 1.0
References: <20211114170335.66994-1-hdegoede@redhat.com> <20211114170335.66994-19-hdegoede@redhat.com>
 <f84e2060-f6b7-64f9-78cd-e8ad8776ab2d@gmail.com> <662623cd-c70b-63e6-499e-7c24b5d3e342@redhat.com>
In-Reply-To: <662623cd-c70b-63e6-499e-7c24b5d3e342@redhat.com>
Reply-To: cwchoi00@gmail.com
From:   Chanwoo Choi <cwchoi00@gmail.com>
Date:   Sat, 20 Nov 2021 00:44:56 +0900
Message-ID: <CAGTfZH1ndMc902R+wJXM+q+4fSJQD+RZVxaWcMvut4+9oSzqnw@mail.gmail.com>
Subject: Re: [PATCH v2 18/20] extcon: intel-cht-wc: Refactor cht_wc_extcon_get_charger()
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sebastian Reichel <sre@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Ard Biesheuvel <ardb@kernel.org>, Len Brown <lenb@kernel.org>,
        linux-acpi@vger.kernel.org, Yauhen Kharuzhy <jekhor@gmail.com>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        platform-driver-x86@vger.kernel.org, linux-i2c@vger.kernel.org,
        Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On Thu, Nov 18, 2021 at 7:31 AM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi,
>
> On 11/17/21 08:15, Chanwoo Choi wrote:
> > Hello,
> >
> > I think that you need to squash it with patch21
> > I'm not sure that this patch is either atomic or not because
> > you remove the 'return EXTCON_CHG_USB_SDP/EXTCON_CHG_USB_SDP'
> > without explaining why it is no problem. Just mention that
> > pass the role to next 'switch' cases. But, before this change,
> > there were any reason to return the type of charger cable
> > before switch statement.
>
> The setting of usbsrc to "CHT_WC_USBSRC_TYPE_SDP << CHT_WC_USBSRC_TYPE_SH=
IFT"
> will make the following switch-case return EXTCON_CHG_USB_SDP
> just as before, so there is no functional change.
>
> > According to your patch description, you don't need
> > to make the separate patch of it. Please squash it with patch21.
>
> Having this refactoring in a separate patch makes it easier
> to see what is going on in patch 21. So I'm going to keep this
> as a separate patch for v3 of this series.

If you want to keep this  patch, please remove the following description.
Instead, just mention to focus on refactor it without behavior changes.

'This is a preparation patch for adding support for registering
a power_supply class device.'

>
>
> > On 21. 11. 15. =EC=98=A4=EC=A0=84 2:03, Hans de Goede wrote:
> >> Refactor cht_wc_extcon_get_charger() to have all the returns are in
> >> the "switch (usbsrc)" cases.
> >>
> >> This is a preparation patch for adding support for registering
> >> a power_supply class device.
> >>
> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >> ---
> >>   drivers/extcon/extcon-intel-cht-wc.c | 15 ++++++++-------
> >>   1 file changed, 8 insertions(+), 7 deletions(-)
> >>
> >> diff --git a/drivers/extcon/extcon-intel-cht-wc.c b/drivers/extcon/ext=
con-intel-cht-wc.c
> >> index 119b83793123..f2b93a99a625 100644
> >> --- a/drivers/extcon/extcon-intel-cht-wc.c
> >> +++ b/drivers/extcon/extcon-intel-cht-wc.c
> >> @@ -153,14 +153,15 @@ static int cht_wc_extcon_get_charger(struct cht_=
wc_extcon_data *ext,
> >>       } while (time_before(jiffies, timeout));
> >>         if (status !=3D CHT_WC_USBSRC_STS_SUCCESS) {
> >> -        if (ignore_errors)
> >> -            return EXTCON_CHG_USB_SDP; /* Save fallback */
> >> +        if (!ignore_errors) {
> >> +            if (status =3D=3D CHT_WC_USBSRC_STS_FAIL)
> >> +                dev_warn(ext->dev, "Could not detect charger type\n")=
;
> >> +            else
> >> +                dev_warn(ext->dev, "Timeout detecting charger type\n"=
);
> >> +        }
> >>   -        if (status =3D=3D CHT_WC_USBSRC_STS_FAIL)
> >> -            dev_warn(ext->dev, "Could not detect charger type\n");
> >> -        else
> >> -            dev_warn(ext->dev, "Timeout detecting charger type\n");
> >> -        return EXTCON_CHG_USB_SDP; /* Save fallback */
> >> +        /* Save fallback */
> >> +        usbsrc =3D CHT_WC_USBSRC_TYPE_SDP << CHT_WC_USBSRC_TYPE_SHIFT=
;
> >>       }
> >>         usbsrc =3D (usbsrc & CHT_WC_USBSRC_TYPE_MASK) >> CHT_WC_USBSRC=
_TYPE_SHIFT;
> >>
> >
> >
>


--=20
Best Regards,
Chanwoo Choi
