Return-Path: <linux-efi+bounces-1945-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 574DD99B5A7
	for <lists+linux-efi@lfdr.de>; Sat, 12 Oct 2024 16:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCF901F21F07
	for <lists+linux-efi@lfdr.de>; Sat, 12 Oct 2024 14:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88761186E2F;
	Sat, 12 Oct 2024 14:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UwLidXZ7"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F29E1EB31;
	Sat, 12 Oct 2024 14:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728744651; cv=none; b=QDobGfy0qymLshg5oxlVClwko9A7cgYdbr3J6+yvfa6ERPR9ve8zcmGhetzkS/9KscTOFgwPOQrGkTcoCQJY11s+EPFIJzGDFJQflep/WzsB17idHnH3Xk/aisrXKSrDqJ9eOHzOUNseqjxnzITMWug5NSjRTij1kCiigxdGHDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728744651; c=relaxed/simple;
	bh=QX+E2MoqsInTymwr8gGklZcL68IiL1oR6T9l6wb+ybo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W3y0Ilyc1zGuzpMrsHeYIzqSuJKskJVUTCKw+inKr2EU9Tm1D1YMLXE7KHca8aCpimjInWzQsH71eIIlRxSaGjy5YHVl3z0Psww/9FgV+9WDFG6G05iGuDT8cVtm3lTlX0o9mtcd10yZTiu7TusSU4RYJLRigwioM1tOt9hCbUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UwLidXZ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12996C4CECE;
	Sat, 12 Oct 2024 14:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728744651;
	bh=QX+E2MoqsInTymwr8gGklZcL68IiL1oR6T9l6wb+ybo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=UwLidXZ79m2fTskmaOZw/yX5lu1Mw27ePOlMoV5x3e0y6Nfr5ugradOg0HXqxNw1s
	 v7mEAhH5pk9KCj9H7HZ9kVKyO7q3Pv/V7u7JOvEz4KZOD04gvKhExlNdURqJVslHl/
	 B4/51yQoSYRgAzt8h/Zv6dJSWg/xIJn/aWriicb4L2y0NfvpauDVwH8uhIvUpnKkv8
	 H4QaXe7oPMdCqLRfl/X6Oehzd4hWLJdOv20+UIqeBkLBdDBrckQYxLKBR94/Q1Pa6P
	 5QDQklXlekopWvmuc3bOmwAbWiUHwtaID7KS/lWC/dqsuIkzWwj2lol7sAnsCv8Asm
	 3ndBGRJB1QnZA==
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539e4b7409fso798991e87.0;
        Sat, 12 Oct 2024 07:50:50 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXwde2FEK3eDnAiCh56eQ99sDjfFe10L53Swt7RwThSEfXpNRRR5oA+sioP3RU3S6gcmZNgf00hz3SQ3Ak=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/y+hdegCah/hXoNPoU5e7Sx/TF0U23K4hNyrNyD67D8QgSqhr
	S+6P4uISN0e1+y/hBpDrTlzz/irnfPmqbRfudQKn046lM9AgpaYITGePPyU+i4iVdwovcjL0neC
	6XlVBF+ZymeZdgET4Mx+m31Yq6QU=
X-Google-Smtp-Source: AGHT+IGIYGLIg1JCdHTfiX5YihgDZZ1OUcLk8Ql4qYpMdNT7gM3swji+/Hw07FZPnlgZIa9uCyBStQQv3Io5Sci3jUU=
X-Received: by 2002:a05:6512:ad2:b0:539:8e58:cdb9 with SMTP id
 2adb3069b0e04-539c98b9632mr2385061e87.30.1728744649452; Sat, 12 Oct 2024
 07:50:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011224812.25763-1-jonathan@marek.ca> <20241011224812.25763-3-jonathan@marek.ca>
 <CAMj1kXHgFVs5Gt5hNao6DTZxqw4dO89OuUMH2tvdWPY1kxfc0Q@mail.gmail.com>
 <acdd3e0d-8ce4-264d-2328-05e7dc353817@marek.ca> <CAMj1kXFe1ZYuR=45VhwMyHcZhSTQVwLrbZDWpgG7Zqw+Awws_A@mail.gmail.com>
 <a6d0d8ae-3cd0-9888-abcd-1db5ab1df011@marek.ca>
In-Reply-To: <a6d0d8ae-3cd0-9888-abcd-1db5ab1df011@marek.ca>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 12 Oct 2024 16:50:37 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH_YbTR9xe7G=ZfqhZ6aBFE8O-ghUe8asd3qqEUN7vdUw@mail.gmail.com>
Message-ID: <CAMj1kXH_YbTR9xe7G=ZfqhZ6aBFE8O-ghUe8asd3qqEUN7vdUw@mail.gmail.com>
Subject: Re: [PATCH 3/3] efi/libstub: consider CONFIG_CMDLINE for initrd= and
 dtb= options
To: Jonathan Marek <jonathan@marek.ca>
Cc: linux-efi@vger.kernel.org, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 12 Oct 2024 at 16:11, Jonathan Marek <jonathan@marek.ca> wrote:
>
> On 10/12/24 9:36 AM, Ard Biesheuvel wrote:
> > On Sat, 12 Oct 2024 at 14:04, Jonathan Marek <jonathan@marek.ca> wrote:
> >>
> >>
> >>
> >> On 10/12/24 3:54 AM, Ard Biesheuvel wrote:
> >>> On Sat, 12 Oct 2024 at 00:52, Jonathan Marek <jonathan@marek.ca> wrote:
> >>>>
> >>>> Replace cmdline with CONFIG_CMDLINE when it should be used instead of
> >>>> load_options.
> >>>>
> >>>> In the EXTEND case, it may be necessary to combine both CONFIG_CMDLINE and
> >>>> load_options. In that case, keep the old behavior and print a warning about
> >>>> the incorrect behavior.
> >>>>
> >>>
> >>> The core kernel has its own handling for EXTEND/FORCE, so while we
> >>> should parse it in the EFI stub to look for options that affect the
> >>> stub's own behavior, we should not copy it into the command line that
> >>> the stub provides to the core kernel.
> >>>
> >>> E.g., drivers/of/fdt.c takes the bootargs from the DT and combines
> >>> them with CONFIG_CMDLINE.
> >>>
> >>>
> >>
> >> I'm aware of that - the replacement the commit message is referring to
> >> is specifically for handle_cmdline_files() which this commit is modifying.
> >>
> >
> > Ah ok - I missed that.
> >
> > This is the kind of context that I'd expect in a cover letter, i.e.,
> > that the command line handling is inconsistent, and that we obtain the
> > command line from the loaded image twice.
> >
> > Also, the fact the initrd= handling and dtb= are special, because
> > a) multiple initrd=  arguments are processed in order, and the files
> > concatenated,
> > b) the filenames are consumed as UTF-16 as they are plugged into the
> > file I/O protocols
> >
>
> (not relevant to this commit, but I need to say that concatenating dtb
> files makes no sense, only the first one will be used by the kernel)
>

Sure, but this code was written for initrd= initially, and was reused for dtb=

> >> Currently efistub completely ignores initrd= and dtb= options provided
> >> through CONFIG_CMDLINE (handle_cmdline_files() only parses the EFI options)
> >>
> >
> > Indeed. You haven't explained why this is a problem. initrd= and dtb=
> > contain references to files in the file system, and this does not seem
> > like something CONFIG_EXTEND was intended for.
> >
>
> Its not the expected/documented behavior, that should be enough to make
> it a problem. Nowhere is it documented that these options would be
> ignored if provided through CONFIG_CMDLINE.
>

Fair enough.

> >> For the EXTEND case, I didn't implement the full solution because its
> >> more complex and EXTEND is not available on arm64 anyway, so I went with
> >> just printing a warning instead.
> >
> > This code is shared between all architectures, so what arm64 does or
> > does not support is irrelevant.
> >
> > Can you explain your use case please?
> >
>
> I boot linux as the "EFI/Boot/bootaa64.efi" on my EFI partition. The
> firmware does not provide any load options. This system needs a dtb, so
> I add the dtb to my EFI partition and configure it using the dtb= option
> (using CONFIG_CMDLINE).

Right.

Would the below work for you? It's not the prettiest code in the
world, but at least it keeps the weird local to the function.

--- a/drivers/firmware/efi/libstub/file.c
+++ b/drivers/firmware/efi/libstub/file.c
@@ -189,26 +189,48 @@
                                  unsigned long *load_addr,
                                  unsigned long *load_size)
 {
-       const efi_char16_t *cmdline = efi_table_attr(image, load_options);
-       u32 cmdline_len = efi_table_attr(image, load_options_size);
        unsigned long efi_chunk_size = ULONG_MAX;
        efi_file_protocol_t *volume = NULL;
+       const efi_char16_t *cmdline;
        efi_file_protocol_t *file;
        unsigned long alloc_addr;
        unsigned long alloc_size;
        efi_status_t status;
+       bool again = false;
+       u32 cmdline_len;
        int offset;

        if (!load_addr || !load_size)
                return EFI_INVALID_PARAMETER;

-       efi_apply_loadoptions_quirk((const void **)&cmdline, &cmdline_len);
-       cmdline_len /= sizeof(*cmdline);
-
        if (IS_ENABLED(CONFIG_X86) && !efi_nochunk)
                efi_chunk_size = EFI_READ_CHUNK_SIZE;

        alloc_addr = alloc_size = 0;
+
+#ifdef CONFIG_CMDLINE
+       if (IS_ENABLED(CONFIG_CMDLINE_FORCE) ||
+           IS_ENABLED(CONFIG_CMDLINE_OVERRIDE) ||
+           (again = (IS_ENABLED(CONFIG_X86) ||
+                     IS_ENABLED(CONFIG_CMDLINE_EXTEND)))) {
+               static const efi_char16_t builtin_cmdline[] = L""
CONFIG_CMDLINE;
+
+               cmdline = builtin_cmdline;
+               cmdline_len = sizeof(builtin_cmdline);
+       } else
+#endif
+       {
+do_load_options:
+               cmdline = efi_table_attr(image, load_options);
+               cmdline_len = efi_table_attr(image, load_options_size);
+
+               efi_apply_loadoptions_quirk((const void **)&cmdline,
+                                           &cmdline_len);
+
+               again = false;
+       }
+       cmdline_len /= sizeof(*cmdline);
+
        do {
                struct finfo fi;
                unsigned long size;
@@ -290,6 +312,9 @@
                efi_call_proto(volume, close);
        } while (offset > 0);

+       if (again)
+               goto do_load_options;
+
        *load_addr = alloc_addr;
        *load_size = alloc_size;

