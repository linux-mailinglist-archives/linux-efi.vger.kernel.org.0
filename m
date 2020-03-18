Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5963B189611
	for <lists+linux-efi@lfdr.de>; Wed, 18 Mar 2020 07:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgCRG7d (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 18 Mar 2020 02:59:33 -0400
Received: from mail-vs1-f68.google.com ([209.85.217.68]:46643 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726553AbgCRG7d (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 18 Mar 2020 02:59:33 -0400
Received: by mail-vs1-f68.google.com with SMTP id z125so15711557vsb.13
        for <linux-efi@vger.kernel.org>; Tue, 17 Mar 2020 23:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=84CyLEGDeMMgsgG4RaCNG98bUTLvwTeDFWdvNMzaPgc=;
        b=LwOldjIv9TqBbm3bBdPv/TQV8lbNHF8shtoJW2FMp8B3D2bBVrSgEsPCIkAtEqPYbU
         I1qFGJ3K/bhCA9x3HBsCSvcLQhiYFZA8dFbYbPO9nVI9p6ODNGY0lQ1FP4Cp9zAKK3FQ
         Jn49klaQ01J+PXjtnf1R6VXsPD9gOhXntyEW0f7TxTnMUWWol8eXkzYpJy5S7lxerAyr
         rIJjzEeox7glZZW878CS1FUKgUgVzZvyf//7SIpZCj/yLac9BICSdfQVDTDPXsFrjDnX
         7NC0nASlTgTVINlRuLnV9e0asZGS40JTZjcbyuJcqGP6j4Up+IgU20KVC+dTzcPM5Pcz
         Yr7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=84CyLEGDeMMgsgG4RaCNG98bUTLvwTeDFWdvNMzaPgc=;
        b=gpxnXiRAJtDDIfo1fEnY1Q5WAUix/r80F8YSjGecy2y0Yr+d+3bedDfSbsH1do+xMr
         k7VpmXvfd76pLIifINLyysI1cyIcma+9pnRF9Syse+BXutct4N3UUiLvIIvB/+Y9isKH
         zD2jqZ3gtQIn1wCjrWG1llS0MSGoLQfyDNo139WiJzpyJELYoXlatOGIIWnOCffGYuZ4
         lVdCuvzN45yIaW7eVlEUucIf3GTMDcED5uW8lcLUKaCpCkstaG8DG4774ZSjpmEwz2jk
         lBVHmtTVmNGub4VZNBrAczV5dYnzP7ft4Ie37wEfIAOuWLHPRwPv82Rq9qX33gRfsOAe
         pRyA==
X-Gm-Message-State: ANhLgQ0pbJqUBsXRxX60UYITQWQu2ro66SV87yUwPYZTeWUPfXeR+tMP
        9tPftuQSy3eD8AhPkA3EiqYXmEzTAXk95jNcmlNDSA==
X-Google-Smtp-Source: ADFU+vtVXVGVP6/sC09G6kPLC+J4DVM6zjb4y8Uz1uz/zwJi6/gkkfTNntH/yl/SPpinD1c3hcUGGWJYLvYcTAfuXc8=
X-Received: by 2002:a05:6102:1cf:: with SMTP id s15mr1919044vsq.109.1584514771785;
 Tue, 17 Mar 2020 23:59:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200312083341.9365-1-jian-hong@endlessm.com> <20200312104643.GA15619@zn.tnic>
 <CAPpJ_eetjhmPwXXXn2y-vibRCK6rrKsFZgC+YGzxO4fMrCKpuQ@mail.gmail.com> <20200316100201.GG26126@zn.tnic>
In-Reply-To: <20200316100201.GG26126@zn.tnic>
From:   Jian-Hong Pan <jian-hong@endlessm.com>
Date:   Wed, 18 Mar 2020 14:58:54 +0800
Message-ID: <CAPpJ_echFt1LbMbjka4r=gPBF9XqGbFUOmUmB8Wi5p9TVK2wuA@mail.gmail.com>
Subject: Re: [PATCH] Revert "x86/reboot, efi: Use EFI reboot for Acer
 TravelMate X514-51T"
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        linux-efi@vger.kernel.org,
        Linux Upstreaming Team <linux@endlessm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Borislav Petkov <bp@alien8.de> =E6=96=BC 2020=E5=B9=B43=E6=9C=8816=E6=97=A5=
 =E9=80=B1=E4=B8=80 =E4=B8=8B=E5=8D=886:01=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Mon, Mar 16, 2020 at 05:17:56PM +0800, Jian-Hong Pan wrote:
> > But, that will raise another question:  Since the original quirk works
> > for all Acer X514-51T and the quirk cannot be removed for older BIOS.
> > Why not keep only original matching items for all Acer X514-51T
> > laptops?
>
> What does the "original matching items" mean?

I should make it more clearly.

The quirk's original matching items for Acer TravelMate X514-51T from
commit 0082517fa4bc ("x86/reboot, efi: Use EFI reboot for Acer
TravelMate X514-51T"):

        {       /* Handle reboot issue on Acer TravelMate X514-51T */
                .callback =3D set_efi_reboot,
                .ident =3D "Acer TravelMate X514-51T",
                .matches =3D {
                        DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
                        DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate X514-51T"),
                },
        },

These matching items make all Acer TravelMate X514-51Ts apply the quirk.

If BIOS version condition is added like:

        {       /* Handle reboot issue on Acer TravelMate X514-51T */
                .callback =3D set_efi_reboot,
                .ident =3D "Acer TravelMate X514-51T",
                .matches =3D {
                        DMI_MATCH(DMI_SYS_VENDOR, "Acer"),
                        DMI_MATCH(DMI_PRODUCT_NAME, "TravelMate X514-51T"),
                        DMI_MATCH(DMI_BIOS_VERSION, "V1.0"),
                },
        },

Then, only Acer TravelMate X514-51T with older BIOS (1.04 and before,
according BIOS version listed on Acer's website [1]) will apply the
quirk.
The one with newer BIOS's reboot type will be defined later by the codes.

[1] https://www.acer.com/ac/en/US/content/support-product/7889?b=3D1

> > I am not sure which option is better.  Any comment?
>
> If you mean, "let's not do anything and fix it only when there's really
> a need to fix anything", then yes, I agree.

Got it!

Thanks,
Jian-Hong Pan
