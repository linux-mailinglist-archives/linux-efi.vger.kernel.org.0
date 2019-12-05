Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BF987113DF3
	for <lists+linux-efi@lfdr.de>; Thu,  5 Dec 2019 10:28:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbfLEJ2g (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 5 Dec 2019 04:28:36 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35636 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728629AbfLEJ2g (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 5 Dec 2019 04:28:36 -0500
Received: by mail-wm1-f65.google.com with SMTP id c20so1361839wmb.0
        for <linux-efi@vger.kernel.org>; Thu, 05 Dec 2019 01:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=r2SNB3l19ozRDzHNGQD+HCGVJCYcshprqr+6bK6lq4Y=;
        b=vKLV4WmFBt862M5lqvg3dMm3zH/ZV2vtcnk0l9au5fmUB5PO0Uf0xoOD1+fo9uvmvK
         CIWZ2X5OP4KXfwIni59ZZaGKIGn7pBlttdB09oPWdZWxmHVQF2q/7USsT6XKNLENg+tc
         GSerzVyuVQKycn8mtKlLKxNBXdEFzJjNrdfQrFV03pr7HLEC5yGod+JCxjgcvBWldxHL
         NRW6HcnNCA59J7Q9eefRkrurMQqr6osX8LUtZrZLaRYi7e0p13tfAv2TjjLrC8WiZJwQ
         BxPlo1Az1u12+cfyCVW6ObB+2047pCTP+Okxb56spJxm0jU6jWL5mrKz4lt86loloIWY
         ++2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r2SNB3l19ozRDzHNGQD+HCGVJCYcshprqr+6bK6lq4Y=;
        b=GqDHtACa7Hu1WkNChFtFLixvALBOPNWipCw8haSnNQ8Crieab6QpetPgX/lYxaDEcM
         SyCEu8S49R3dfm+RfBhZggZzz+nfjoHs+kNK7hu5jIEV9M/EyCAapjg8JO6YINertnys
         eQj/8T2fIPgrYhAJLvfrppqf93QMO7Qb0ArLEhIIC484i2SP0U2b5/Mbt875Qx4HSEO/
         tDy41mUJJmFvu0pnuYonc0bZYyydY7lWInEtiFVJGNKHF9Rr/q6bliWN6DkijygLRKuX
         oMvZzrw8M3AKRFsbNWDQQqb8nNk+4gAx1qQs9x+fs9SmcxkOTDBBcnpIb5kvE+09mvnP
         iiTQ==
X-Gm-Message-State: APjAAAVP8SxkH6tJy7+XOGR+d2pddg61SUzELIjd3Pd+BgMZJ5Yjcmdw
        g2C6zZffy38liHgQ75GvlcsH4bDx4lTYllYAyjTSrg==
X-Google-Smtp-Source: APXvYqyGFuPgx5/Vf1TDlqbpy8l+PU91mXIP8Q6Yx96k9y/h7397xdAVP2YG1BdZjxMHNQaC6hIoee3BwvSl+QqhnJs=
X-Received: by 2002:a1c:7205:: with SMTP id n5mr4202075wmc.9.1575538113040;
 Thu, 05 Dec 2019 01:28:33 -0800 (PST)
MIME-Version: 1.0
References: <20191204145233.11962-1-ardb@kernel.org> <20191204171744.o3ijdspnelqn5fgd@gabell>
 <08f05b18-12b2-0ba4-b819-b95ba27d1862@arm.com> <20191204185708.hdoa5gzmfr547q53@gabell>
 <CAFTCetTTgJRN+3+vqS+XbMMrra3xKqrEXzqEKpLsMn=G8peUjw@mail.gmail.com>
In-Reply-To: <CAFTCetTTgJRN+3+vqS+XbMMrra3xKqrEXzqEKpLsMn=G8peUjw@mail.gmail.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 5 Dec 2019 09:28:29 +0000
Message-ID: <CAKv+Gu8tOho+5DDQ-N4vkgLENEsLzgmNO9A+Vgf_G2sSCRuNNQ@mail.gmail.com>
Subject: Re: [PATCH] efi/memreserve: register reservations as 'reserved' in /proc/iomem
To:     Bhupesh SHARMA <bhupesh.linux@gmail.com>
Cc:     Masayoshi Mizuma <msys.mizuma@gmail.com>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Kexec Mailing List <kexec@lists.infradead.org>,
        d.hatayama@fujitsu.com, Ard Biesheuvel <ardb@kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Bhupesh Sharma <bhsharma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, 4 Dec 2019 at 20:13, Bhupesh SHARMA <bhupesh.linux@gmail.com> wrote:
>
> Hello Masa,
>
> (+Cc Simon)
>
> On Thu, Dec 5, 2019 at 12:27 AM Masayoshi Mizuma <msys.mizuma@gmail.com> wrote:
> >
> > On Wed, Dec 04, 2019 at 06:17:59PM +0000, James Morse wrote:
> > > Hi Masa,
> > >
> > > On 04/12/2019 17:17, Masayoshi Mizuma wrote:
> > > > Thank you for sending the patch, but unfortunately it doesn't work for the issue...
> > > >
> > > > After applied your patch, the LPI tables are marked as reserved in
> > > > /proc/iomem like as:
> > > >
> > > > 80300000-a1fdffff : System RAM
> > > >   80480000-8134ffff : Kernel code
> > > >   81350000-817bffff : reserved
> > > >   817c0000-82acffff : Kernel data
> > > >   830f0000-830fffff : reserved # Property table
> > > >   83480000-83480fff : reserved # Pending table
> > > >   83490000-8349ffff : reserved # Pending table
> > > >
> > > > However, kexec tries to allocate memory from System RAM, it doesn't care
> > > > the reserved in System RAM.
> > >
> > > > I'm not sure why kexec doesn't care the reserved in System RAM, however,
> > >
> > > Hmm, we added these to fix a problem with the UEFI memory map, and more recently ACPI
> > > tables being overwritten by kexec.
> > >
> > > Which version of kexec-tools are you using? Could you try:
> > > https://git.linaro.org/people/takahiro.akashi/kexec-tools.git/commit/?h=arm64/resv_mem
> >
> > Thanks a lot! It worked and the issue is gone with Ard's patch and
> > the linaro kexec (arm64/resv_mem branch).
> >
> > Ard, please feel free to add:
> >
> >         Tested-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
>
> Same results at my side, so:
> Tested-and-Reviewed-by: Bhipesh Sharma <bhsharma@redhat.com>
>

Thank you all. I'll get this queued as a fix with cc:stable for v5.4


> > >
> > > > if the kexec behaivor is right, the LPI tables should not belong to
> > > > System RAM.
> > >
> > > > Like as:
> > > >
> > > > 80300000-830effff : System RAM
> > > >   80480000-8134ffff : Kernel code
> > > >   81350000-817bffff : reserved
> > > >   817c0000-82acffff : Kernel data
> > > > 830f0000-830fffff : reserved # Property table
> > > > 83480000-83480fff : reserved # Pending table
> > > > 83490000-8349ffff : reserved # Pending table
> > > > 834a0000-a1fdffff : System RAM
> > > >
> > > > I don't have ideas to separete LPI tables from System RAM... so I tried
> > > > to add a new file to inform the LPI tables to userspace.
> > >
> > > This is how 'nomap' memory appears, we carve it out of System RAM. A side effect of this
> > > is kdump can't touch it, as you've told it this isn't memory.
> > >
> > > As these tables are memory, mapped by the linear map, I think Ard's patch is the right
> > > thing to do ... I suspect your kexec-tools doesn't have those patches from Akashi to make
> > > it honour all second level entries.
> >
> > I used the kexec on the top of master branch:
> > git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
> >
> > Should we use the linaro kexec for aarch64 machine?
> > Or will the arm64/resv_mem branch be merged to the kexec on
> > git.kernel.org...?
>
> Glad that Ard's patch fixes the issue for you.
> Regarding Akashi's patch, I think it was sent to upstream kexec-tools
> some time ago (see [0}) but  seems not integrated in upstream
> kexec-tools (now I noticed my Tested-by email for the same got bounced
> off due to some gmail msmtp setting issues at my end - sorry for
> that). I have added Simon in Cc list.
>
> Hi Simon,
>
> Can you please help pick [0] in upstream kexec-tools with Tested-by
> from Masa and myself? Thanks a lot for your help.
>
> [0]. http://lists.infradead.org/pipermail/kexec/2019-January/022201.html
>
> Thanks,
> Bhupesh
