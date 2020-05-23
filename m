Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 502C61DF7F9
	for <lists+linux-efi@lfdr.de>; Sat, 23 May 2020 17:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387883AbgEWPQq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 23 May 2020 11:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387815AbgEWPQp (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 23 May 2020 11:16:45 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE9CC061A0E;
        Sat, 23 May 2020 08:16:45 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id v79so3617294qkb.10;
        Sat, 23 May 2020 08:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s97ajZD90rgqdXs/R0Xy3++PiOxk3MHUrsLK+PCJmfE=;
        b=VjdBxOq13qItPXudWb2W4hHV5ImOZ5AndLFCQT1Yz2Z2nPT8oCaAtOKFOTL/IhL1cE
         p8KxHYAenn4FJ2GVdHyqCZjUJ/vC+izjgTCuvr62qpbG8NrjMCkhMw/ma/HzwS/HNk86
         yLdKhxEMHnYl8PHnY3xN7oMyni2rbxtZbaGJ6yzZCBaML9LqMQN63YZpl97p/hYSeaRM
         ICdvUKslwtePSsYL/96fF9oPiA7dtJfy+mkVrNWWVzBzg63nEY2EbK/AL9mZD1MX322h
         xN++4GpGif6xAloET+kBRkz2uU/SlUkMR17Unn6WIUEsZkz9yYMOYNl9QZD3prn6dDjf
         hbrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=s97ajZD90rgqdXs/R0Xy3++PiOxk3MHUrsLK+PCJmfE=;
        b=EtJ8JvTA1ItTqUIpxRAe5wlO1QT4r7iKRydAQL87jBGGwl4UuuMgi0Q2Y9rwz/1iG7
         khISOo6X1asdpfXMgZm6UhiU0QMYtrXv7D8DH1zn1TRmz1ui9gFh3+Sl+fNLhvWk7cfs
         2Xkv2eFOMyn/QBWexp5MvuATpRMmcngjltW2FDj4EVS8e8wvC9bk9EfjT8NmWEiqVqyZ
         63SgADs/1xEswONUsbySnTaocP8HhvyitDmhjXupdgG1Znpfbq4z5Ja1M/3RJDHajJ8W
         2PKQ/dpJCg1562zCpNXtrwRllu4t9MpmhM6bYVV1e1NH/4R7xMS1MmT/zyCj3RdiRO2+
         SZjQ==
X-Gm-Message-State: AOAM532X4IAzNHwDI/alqRtwcX9D+KIHIZZ2Y5KpFl0pqvSEYdb26tfU
        1ZqgFR7m0+N8GjJekiRyExrze1LC
X-Google-Smtp-Source: ABdhPJzQ53y3IgvwyCJf0f1WhiKzdTHnGWGtisvWDBshYQIOahm8X26JBQVTho9FJk4AtN4anJMX3g==
X-Received: by 2002:ae9:ed95:: with SMTP id c143mr19891162qkg.394.1590247004541;
        Sat, 23 May 2020 08:16:44 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 70sm6704656qkk.10.2020.05.23.08.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 08:16:43 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sat, 23 May 2020 11:16:42 -0400
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arvind Sankar <nivedita@alum.mit.edu>
Subject: Re: [PATCH v2 0/3] x86/boot: get rid of GOT entries and associated
 fixup code
Message-ID: <20200523151642.GA1189358@rani.riverdale.lan>
References: <20200523120021.34996-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200523120021.34996-1-ardb@kernel.org>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, May 23, 2020 at 02:00:18PM +0200, Ard Biesheuvel wrote:
> Building position independent code using GCC by default results in references
> to symbols with external linkage to be resolved via GOT entries, which
> carry the absolute addresses of the symbols, and thus need to be corrected
> if the load time address of the executable != the link time address.
> 
> For fully linked binaries, such GOT indirected references are completely
> useless, and actually make the startup code more complicated than necessary,
> since these corrections may need to be applied more than once. In fact, we
> have been very careful to avoid such references in the EFI stub code, since
> it would require yet another [earlier] pass of GOT fixups which we currently
> don't implement.
> 
> Older GCCs were quirky when it came to overriding this behavior using symbol
> visibility, but now that we have increased the minimum GCC version to 4.6,
> we can actually start setting the symbol visibility to 'hidden' globally for
> all symbol references in the decompressor, getting rid of the GOT entirely.
> This means we can get rid of the GOT fixup code right away, and we can start
> using ordinary external symbol references in the EFI stub without running the
> risk of boot regressions. (v2 note: we have already started doing this)
> 
> CC'ing Linus and Maarten, who were involved in diagnosing an issue related
> to GOT entries emitted from the EFI stub ~5 years ago. [0] [1]
> 
> Many thanks to Arvind for the suggestions and the help in testing these
> changes. Tested on GCC 4.6 + binutils 2.24 (Ubuntu 14.04), and GCC 8 +
> binutils 2.31 (Debian Buster)
> 
> Changes since v1 [2]:
> Rebase only - recent EFI changes have moved all the C code into
> drivers/firmware/efi/libstub/, which is also built with hidden
> visibility, and contains an additional objdump pass to detect (and
> reject) absolute symbol references.
> 
> Unless anyone objects, I'd like to incorporate these changes into my
> late EFI PR for v5.8, which will go out in a day or two.
> 
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Arvind Sankar <nivedita@alum.mit.edu>
> 
> [0] https://lore.kernel.org/lkml/5405E186.2080406@canonical.com/
> [1] https://lore.kernel.org/lkml/CA+55aFxW9PmtjOf9nUQwpU8swsFqJOz8whZXcONo+XFmkSwezg@mail.gmail.com/
> [2] https://lore.kernel.org/linux-efi/20200108102304.25800-1-ardb@kernel.org/
> 

Haha, I was actually doing exactly the same thing as part of getting the
compressed kernel linkable with LLD.

Acked-by: Arvind Sankar <nivedita@alum.mit.edu>
