Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22009132DFF
	for <lists+linux-efi@lfdr.de>; Tue,  7 Jan 2020 19:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbgAGSIM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 7 Jan 2020 13:08:12 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39151 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728451AbgAGSIM (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 7 Jan 2020 13:08:12 -0500
Received: by mail-qk1-f196.google.com with SMTP id c16so207427qko.6
        for <linux-efi@vger.kernel.org>; Tue, 07 Jan 2020 10:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=DhDpeXWO1F8BCFaCIk4BGpBO9Vg59g12XL8o9IpUhD8=;
        b=qPeY3Sts6j55Ag+iJRoDBpSD22mNLiL7wwZzbXWEAWcz1T/y0LWXAMp2eAgxCUqhr9
         nMwksSjfEOTyiqbASYbtJtX4XOelzZ/nzD0VcyrslnTQDSWgGhT14SwiCjqFmYkSPRBP
         Zg5mQ3Gx4JeB0UOa/acQhLhgvBFqIVUBD0I57kR2uksUTio2czpYprnvyEpGc2zMiLcX
         RA8841e00x9leXKfuPdCC580bL4T5M1WY5UecmSOZytSdXUyBjYmebots2A9ntaUwiyf
         JSi/kr/+fGdPVsIYi9429wYK2tF5BFebh6jSJlQMS2BbZRdp/Cnrno1M0DTxuQ1pYLEX
         hD+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=DhDpeXWO1F8BCFaCIk4BGpBO9Vg59g12XL8o9IpUhD8=;
        b=qZnFLWlqepPOrf6tkysQ/M3/VsLm1cm3oQe2OzaDqIHSDOP/EfwIC15f9Glukv12tY
         ZV5Q6+m8uGVjj3rHnv+6l27OOh8niTr9bNKP+LgE3IESk8WPp30HVSjklQIATjkspkwf
         6Jr+xHOxIVSs/Bv7jxLtcY+UX0AIwN8kgris7dmvvxBLCslkwo4bUcQYXTKY1xkGmdOf
         gQ23Oz2SZNl3ijGvh/QGc+ZHmgxwG7aNAM3Z7uD6PFN2fVO0LUuTbqKDgCjxTFRhUWzb
         gYt8LrxcYIYqIzbhn3oW4+xupS3o3eBgm7aq4zk2f0knR1kKPuFxNjClw1YootzoEYXm
         tT0w==
X-Gm-Message-State: APjAAAV56AB1UVIF3FLYroax4DS5k/LKKivBe8jelAkGTH/PMQKhLZNp
        w+PmLh5U8weX9KJUkyC3Kz+10jZn
X-Google-Smtp-Source: APXvYqyj0X8WDMtqYxO5oSApTRit1HN6Uk2WgzxWzdQT1B4fe/q3LKj9iM78JaYJ+u1QXyYyTq4zFA==
X-Received: by 2002:a37:9647:: with SMTP id y68mr585613qkd.300.1578420490444;
        Tue, 07 Jan 2020 10:08:10 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id n1sm143403qkk.122.2020.01.07.10.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 10:08:10 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 7 Jan 2020 13:08:08 -0500
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Subject: Re: [PATCH 0/3] Relocate GOT before calling EFI stub
Message-ID: <20200107180807.GA1642410@rani.riverdale.lan>
References: <20200107135500.644618-1-nivedita@alum.mit.edu>
 <CAKv+Gu8HE-QJBpo=S_uUbqkO8BfbKyrp2+nCTxWhPVNMU1E37g@mail.gmail.com>
 <CAKv+Gu_+a4igmTHhMgg17B2oH5f=KRM2g2CBGy+LnF5wYsarng@mail.gmail.com>
 <20200107142125.GA652888@rani.riverdale.lan>
 <CAKv+Gu-xDaTBVKJ=9ya74giBZ=LdX2r-8-LiFJWzcUofthGv7w@mail.gmail.com>
 <20200107142732.GB652888@rani.riverdale.lan>
 <CAKv+Gu8v-5DXWh5ZaY0omrVNh46TEourpcf2Hv3TrsbCUtLFng@mail.gmail.com>
 <20200107175829.GA1599060@rani.riverdale.lan>
 <CAKv+Gu-PU=LqT7MEbSH-0GnJOdakDeaC=ANdmag6JptcfJEJtA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-PU=LqT7MEbSH-0GnJOdakDeaC=ANdmag6JptcfJEJtA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jan 07, 2020 at 06:59:57PM +0100, Ard Biesheuvel wrote:
> On Tue, 7 Jan 2020 at 18:58, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Tue, Jan 07, 2020 at 03:28:31PM +0100, Ard Biesheuvel wrote:
> > >
> > > Unfortunately, the command line option implements a weaker form of
> > > visibility than the pragma, so it probably comes down to setting the
> > > pragma in a .h file that gets -include'd via the command line so it is
> > > guaranteed to be seen first.
> >
> > Tried hacking that in and it works, tested with gcc 4.6.4.
> 
> Excellent. But in my testing locally, I don't get any GOT entries in
> the first place, strangely enough. So what changes in the output for
> you with visibility hidden compared to before?

Works with 32-bit as well.

Are you checking libstub or boot/compressed? Below is with gcc 4.6 (but
latest binutils). With gcc 9, there's only one left -- trampoline_32bit_src
in pgtable_64.

acpi.o
000000000000025b R_X86_64_REX_GOTPCRELX  boot_params-0x0000000000000004
cmdline.o
00000000000001d3 R_X86_64_REX_GOTPCRELX  boot_params-0x0000000000000004
00000000000001f3 R_X86_64_REX_GOTPCRELX  boot_params-0x0000000000000004
0000000000000223 R_X86_64_REX_GOTPCRELX  boot_params-0x0000000000000004
cpuflags.o
00000000000000a3 R_X86_64_REX_GOTPCRELX  cpu_vendor-0x0000000000000004
00000000000000c5 R_X86_64_REX_GOTPCRELX  cpu-0x0000000000000004
0000000000000127 R_X86_64_REX_GOTPCRELX  cpu-0x0000000000000004
0000000000000144 R_X86_64_REX_GOTPCRELX  cpu-0x0000000000000004
0000000000000153 R_X86_64_REX_GOTPCRELX  cpu-0x0000000000000004
000000000000017b R_X86_64_REX_GOTPCRELX  cpu-0x0000000000000004
early_serial_console.o
000000000000005a R_X86_64_REX_GOTPCRELX  early_serial_base-0x0000000000000004
0000000000000165 R_X86_64_REX_GOTPCRELX  early_serial_base-0x0000000000000004
eboot.o
efi_thunk_64.o
error.o
head_64.o
kaslr_64.o
00000000000001e7 R_X86_64_REX_GOTPCRELX  ptrs_per_p4d-0x0000000000000004
0000000000000372 R_X86_64_REX_GOTPCRELX  __default_kernel_pte_mask-0x0000000000000004
000000000000038b R_X86_64_REX_GOTPCRELX  pgdir_shift-0x0000000000000004
00000000000003ac R_X86_64_REX_GOTPCRELX  __pgtable_l5_enabled-0x0000000000000004
000000000000040a R_X86_64_REX_GOTPCRELX  __pgtable_l5_enabled-0x0000000000000004
00000000000004db R_X86_64_REX_GOTPCRELX  __force_order-0x0000000000000004
00000000000004f2 R_X86_64_REX_GOTPCRELX  __pgtable_l5_enabled-0x0000000000000004
0000000000000517 R_X86_64_REX_GOTPCRELX  _pgtable-0x0000000000000004
00000000000005f3 R_X86_64_REX_GOTPCRELX  __force_order-0x0000000000000004
kaslr.o
0000000000000281 R_X86_64_REX_GOTPCRELX  boot_params-0x0000000000000004
00000000000003e3 R_X86_64_REX_GOTPCRELX  boot_params-0x0000000000000004
0000000000000ba1 R_X86_64_REX_GOTPCRELX  __force_order-0x0000000000000004
0000000000000bb4 R_X86_64_REX_GOTPCRELX  boot_params-0x0000000000000004
0000000000000cc8 R_X86_64_REX_GOTPCRELX  free_mem_ptr-0x0000000000000004
0000000000000cd2 R_X86_64_REX_GOTPCRELX  free_mem_end_ptr-0x0000000000000004
0000000000000d6e R_X86_64_REX_GOTPCRELX  free_mem_ptr-0x0000000000000004
0000000000000f63 R_X86_64_REX_GOTPCRELX  __pgtable_l5_enabled-0x0000000000000004
kernel_info.o
mem_encrypt.o
misc.o
0000000000000015 R_X86_64_REX_GOTPCRELX  free_mem_ptr-0x0000000000000004
000000000000001f R_X86_64_REX_GOTPCRELX  free_mem_end_ptr-0x0000000000000004
0000000000002965 R_X86_64_REX_GOTPCRELX  early_serial_base-0x0000000000000004
0000000000002a43 R_X86_64_REX_GOTPCRELX  boot_params-0x0000000000000004
0000000000002b8e R_X86_64_REX_GOTPCRELX  boot_params-0x0000000000000004
0000000000002bec R_X86_64_REX_GOTPCRELX  boot_params-0x0000000000000004
0000000000002c10 R_X86_64_REX_GOTPCRELX  free_mem_end_ptr-0x0000000000000004
0000000000002c17 R_X86_64_REX_GOTPCRELX  free_mem_ptr-0x0000000000000004
0000000000002d16 R_X86_64_REX_GOTPCRELX  trampoline_32bit-0x0000000000000004
0000000000002f97 R_X86_64_REX_GOTPCRELX  boot_params-0x0000000000000004
0000000000002fea R_X86_64_REX_GOTPCRELX  boot_params-0x0000000000000004
pgtable_64.o
000000000000000d R_X86_64_REX_GOTPCRELX  boot_params-0x0000000000000004
000000000000010a R_X86_64_REX_GOTPCRELX  trampoline_32bit_src-0x0000000000000004
0000000000000191 R_X86_64_REX_GOTPCRELX  __force_order-0x0000000000000004
0000000000000376 R_X86_64_REX_GOTPCRELX  __force_order-0x0000000000000004
piggy.o
string.o
