Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D93E91C2DD4
	for <lists+linux-efi@lfdr.de>; Sun,  3 May 2020 18:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbgECQJt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 3 May 2020 12:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728665AbgECQJs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 3 May 2020 12:09:48 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42FC7C061A0E;
        Sun,  3 May 2020 09:09:47 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id w29so12007973qtv.3;
        Sun, 03 May 2020 09:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hP+vX8MHPGS7CsHwOvPpHTGmKhgaIDUIILLY2nG2/lk=;
        b=LNUZTDHvCz7hUTrETkMO1h1ojMlXHD7fOHUA5K64K/pRTXIZyK7eBeqXNYs3JI37+b
         l1KAssHLR9Rvd2K8vwtEXsb45MZNcCPKty6BD4pD7ZXkOwDy+1AUm8Df/Zv0SkZ0bNVp
         llMwg/i+gUOmtRj9+LMK1xLbIaSl28wx5HyY/Pk8p4lZnFgqIWKmaLFw8eK/R8xiDHm9
         1FLs7lktAm0HT6uziq9uw+gszpf9uz5YRsYybeV2hvbe0ugNeBNfom2EdZU3f8s62OuL
         RMxkw7ND+0MQqDdNluYgM/tnrETvTfvxOQ6sQzZAfFKPMzXO/attXLltAbPg/rAB8b0f
         JpCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=hP+vX8MHPGS7CsHwOvPpHTGmKhgaIDUIILLY2nG2/lk=;
        b=cRD4sthpmACSDuyj877uOi7qMCkVipCQeT6zphNA14c03RvJhjtraDkqESMYRPaifF
         5bAp7zg5Hh70a0QC4EVCg9yTURg9VD6o/h/oYVUsWsJXBgBauVopIEucjBwPhaHAjE6s
         CcMHyq8WrGPrq/uU4IiwK5fEOaLs2XmXg+AbiZ4cAtqGenE+1W7DUdRh3PtrrzjKdNC7
         /T4/MRBbYi7ZcxUyYQrn6pSdqxaEOGiu8DwGW+3H0+VMQpYeHwwDzbA81igGcMtkJ/hF
         ADvAJp0T3uF5fVDt+7zMznEmgE+wKqyoFLMc3d1YuOx9pmLfnuEDx5W/luRneyxcvQps
         WBOw==
X-Gm-Message-State: AGi0PubKYt3D66g05uo12sC3fLAiwP6/NlqSphjgRrDsETelOn571eXL
        WXXubj14z5QOINPYtB7zLIQ=
X-Google-Smtp-Source: APiQypKcEowcP1JLdHYaFzRJz4yUW59GKsmtbdYfffAX6yQWEmc7ER+25kdl2zuVNVtBXOxYVfQhgA==
X-Received: by 2002:aed:3aa3:: with SMTP id o32mr13546650qte.364.1588522186219;
        Sun, 03 May 2020 09:09:46 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id a124sm7835396qkf.93.2020.05.03.09.09.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2020 09:09:45 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sun, 3 May 2020 12:09:43 -0400
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Zou Wei <zou_wei@huawei.com>
Subject: Re: [PATCH 03/33] efi/libstub: Unify EFI call wrappers for non-x86
Message-ID: <20200503160943.GA718804@rani.riverdale.lan>
References: <20200424130531.30518-1-ardb@kernel.org>
 <20200424130531.30518-4-ardb@kernel.org>
 <20200503150906.GA57805@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200503150906.GA57805@roeck-us.net>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sun, May 03, 2020 at 08:09:06AM -0700, Guenter Roeck wrote:
> Hi,
> 
> On Fri, Apr 24, 2020 at 03:05:01PM +0200, Ard Biesheuvel wrote:
> > We have wrappers around EFI calls so that x86 can define special
> > versions for mixed mode, while all other architectures can use the
> > same simple definition that just issues the call directly.
> > In preparation for the arrival of yet another architecture that doesn't
> > need anything special here (RISC-V), let's move the default definition
> > into a shared header.
> > 
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> 
> This patch causes an immediate reboot in linux-next when booting
> in qemu with an efi32 bios. Bisect log attached.
> 
> Qemu command line:
> 
> qemu-system-x86_64 -kernel arch/x86/boot/bzImage -m 1G \
> 	-no-reboot -snapshot \
> 	-bios OVMF-pure-efi-32.fd \
> 	-drive file=rootfs.ext2,format=raw \
> 	--append 'earlycon=uart8250,io,0x3f8,9600n8 panic=-1 root=/dev/sda console=ttyS0' \
> 	-nographic
> 
> The same command succeeds with OVMF-pure-efi-64.fd.
> 
> Bisect log attached.
> 
> File locations:
> 	https://github.com/groeck/linux-build-test/blob/master/rootfs/firmware/OVMF-pure-efi-32.fd
> 	https://github.com/groeck/linux-build-test/blob/master/rootfs/x86_64/rootfs.ext2.gz
> 
> Guenter
> 

The issue is that efi_is_native is an inline function on x86, not a
macro, so the #ifndef efi_is_native is broken.

We can either turn it into a macro, or add
	#define efi_is_native efi_is_native
in arch/x86/include/asm/efi.h.
