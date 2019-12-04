Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB930113631
	for <lists+linux-efi@lfdr.de>; Wed,  4 Dec 2019 21:13:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727887AbfLDUNm (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Dec 2019 15:13:42 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:38465 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbfLDUNm (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Dec 2019 15:13:42 -0500
Received: by mail-ot1-f66.google.com with SMTP id h20so445729otn.5
        for <linux-efi@vger.kernel.org>; Wed, 04 Dec 2019 12:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nWf2HTlHvajnOuURdmbOCH1BsMPANlvcDtR+uHH1c/o=;
        b=LaJ7pai1S22jwtQBuUu+xJpLL2O5wIxvYPOa7kmofO1qrsqHIcia4UAZlCa4mD282A
         zFy+R97gPfUjQmj7mshqvs5A/Kcr65C4vI4Wbq6shDL2UFxBy+Bdw8dBDLK3QnikVACF
         zSbrkwHWsLm/lOyrKvgVmKx8As6hYzHFXxEmxXs6DMFWd3GHwI9DAT7DWh5msg6/I3Bu
         2cjdtcP2VZydRW9CPuGDzqjD5ZvDlEd/9+aqvh8h61suns4z6f4kiMPI7o7Abb0D/Dul
         /35isVuP8/DMTHbFsdAjf7U6zh5B0J4DV/5N1TNJ2rd4ZDOXnyM8oJecqvWwyZmqoEEk
         96lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nWf2HTlHvajnOuURdmbOCH1BsMPANlvcDtR+uHH1c/o=;
        b=p2S+7GhcZNDIDfnjH0ig5R/HBVcVqlMRAHHrXx38ancX8Uvfl+mHqwOFzDQUFEiAMf
         rAkcQ1up7PqxCKex6iVSBrQc/x2V4FoqGcaaLbGg8ZJ5oLsJCZ4WHLR3YwIjmS/BQReF
         QlIVQRaU1urRwpPOe9A9m+P8/sQ+cVNDhdi67k3DUajjoVxRpgXDLzKfdYy9mJSPbelY
         0wJq8dlo3W82+5/4QihtWX1okR1Y+bzB6eWe3ukNdl2b3n1H2BptC3sGN6XLnYN9Uhvk
         64liuZGsd1kgwHBc8SFbBCzi3Kqw9CttNOxghVBHyifOSLXOzxYEfgD1Mr1nkKL0mGii
         H1IQ==
X-Gm-Message-State: APjAAAVgMyZqu8XuNMJq86O4tPPW2knVvkyTViOtw3K4YApT2Svvp5Ix
        2QFH5UVClCP/91WXIVJ8WkPFJMIOUVDhCvnNgrQ=
X-Google-Smtp-Source: APXvYqyHo1oKl4GlHZNqIdSh9s/yhdk6UrxPzDtc2W5FdljAfSMCHXimGZ8nSQ4DxF/SA85CwrN3CWQb7cGs1IHoLro=
X-Received: by 2002:a9d:7f16:: with SMTP id j22mr3857585otq.256.1575490420992;
 Wed, 04 Dec 2019 12:13:40 -0800 (PST)
MIME-Version: 1.0
References: <20191204145233.11962-1-ardb@kernel.org> <20191204171744.o3ijdspnelqn5fgd@gabell>
 <08f05b18-12b2-0ba4-b819-b95ba27d1862@arm.com> <20191204185708.hdoa5gzmfr547q53@gabell>
In-Reply-To: <20191204185708.hdoa5gzmfr547q53@gabell>
From:   Bhupesh SHARMA <bhupesh.linux@gmail.com>
Date:   Thu, 5 Dec 2019 01:43:28 +0530
Message-ID: <CAFTCetTTgJRN+3+vqS+XbMMrra3xKqrEXzqEKpLsMn=G8peUjw@mail.gmail.com>
Subject: Re: [PATCH] efi/memreserve: register reservations as 'reserved' in /proc/iomem
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-efi@vger.kernel.org, kexec@lists.infradead.org,
        d.hatayama@fujitsu.com, Ard Biesheuvel <ardb@kernel.org>,
        Simon Horman <horms@verge.net.au>,
        Bhupesh Sharma <bhsharma@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hello Masa,

(+Cc Simon)

On Thu, Dec 5, 2019 at 12:27 AM Masayoshi Mizuma <msys.mizuma@gmail.com> wrote:
>
> On Wed, Dec 04, 2019 at 06:17:59PM +0000, James Morse wrote:
> > Hi Masa,
> >
> > On 04/12/2019 17:17, Masayoshi Mizuma wrote:
> > > Thank you for sending the patch, but unfortunately it doesn't work for the issue...
> > >
> > > After applied your patch, the LPI tables are marked as reserved in
> > > /proc/iomem like as:
> > >
> > > 80300000-a1fdffff : System RAM
> > >   80480000-8134ffff : Kernel code
> > >   81350000-817bffff : reserved
> > >   817c0000-82acffff : Kernel data
> > >   830f0000-830fffff : reserved # Property table
> > >   83480000-83480fff : reserved # Pending table
> > >   83490000-8349ffff : reserved # Pending table
> > >
> > > However, kexec tries to allocate memory from System RAM, it doesn't care
> > > the reserved in System RAM.
> >
> > > I'm not sure why kexec doesn't care the reserved in System RAM, however,
> >
> > Hmm, we added these to fix a problem with the UEFI memory map, and more recently ACPI
> > tables being overwritten by kexec.
> >
> > Which version of kexec-tools are you using? Could you try:
> > https://git.linaro.org/people/takahiro.akashi/kexec-tools.git/commit/?h=arm64/resv_mem
>
> Thanks a lot! It worked and the issue is gone with Ard's patch and
> the linaro kexec (arm64/resv_mem branch).
>
> Ard, please feel free to add:
>
>         Tested-by: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>

Same results at my side, so:
Tested-and-Reviewed-by: Bhipesh Sharma <bhsharma@redhat.com>

> >
> > > if the kexec behaivor is right, the LPI tables should not belong to
> > > System RAM.
> >
> > > Like as:
> > >
> > > 80300000-830effff : System RAM
> > >   80480000-8134ffff : Kernel code
> > >   81350000-817bffff : reserved
> > >   817c0000-82acffff : Kernel data
> > > 830f0000-830fffff : reserved # Property table
> > > 83480000-83480fff : reserved # Pending table
> > > 83490000-8349ffff : reserved # Pending table
> > > 834a0000-a1fdffff : System RAM
> > >
> > > I don't have ideas to separete LPI tables from System RAM... so I tried
> > > to add a new file to inform the LPI tables to userspace.
> >
> > This is how 'nomap' memory appears, we carve it out of System RAM. A side effect of this
> > is kdump can't touch it, as you've told it this isn't memory.
> >
> > As these tables are memory, mapped by the linear map, I think Ard's patch is the right
> > thing to do ... I suspect your kexec-tools doesn't have those patches from Akashi to make
> > it honour all second level entries.
>
> I used the kexec on the top of master branch:
> git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
>
> Should we use the linaro kexec for aarch64 machine?
> Or will the arm64/resv_mem branch be merged to the kexec on
> git.kernel.org...?

Glad that Ard's patch fixes the issue for you.
Regarding Akashi's patch, I think it was sent to upstream kexec-tools
some time ago (see [0}) but  seems not integrated in upstream
kexec-tools (now I noticed my Tested-by email for the same got bounced
off due to some gmail msmtp setting issues at my end - sorry for
that). I have added Simon in Cc list.

Hi Simon,

Can you please help pick [0] in upstream kexec-tools with Tested-by
from Masa and myself? Thanks a lot for your help.

[0]. http://lists.infradead.org/pipermail/kexec/2019-January/022201.html

Thanks,
Bhupesh
