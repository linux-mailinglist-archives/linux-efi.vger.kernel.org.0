Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 95DBD15C9BD
	for <lists+linux-efi@lfdr.de>; Thu, 13 Feb 2020 18:53:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727594AbgBMRxW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Feb 2020 12:53:22 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:32947 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgBMRxW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 13 Feb 2020 12:53:22 -0500
Received: by mail-qt1-f196.google.com with SMTP id d5so5067135qto.0
        for <linux-efi@vger.kernel.org>; Thu, 13 Feb 2020 09:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hQ4ih0UdB0NOdAJLRyAfFoXRg3IBMsGXrVzfh23+lBw=;
        b=Kmj6kGwADmeI+i1sw5YMjjG9i1Y31gd4TLRBsWIEpyuiB+fRrtOHYVC5B9ImxSIoZ2
         Cw/oHnKFjCVU0dhX46dH0EaiB2wwDqcskaMGgnN7sXZrfq4oOAHB5m9/gqJhU/ca0zwJ
         TgiXfGHsXxfkXsjyNRfVh/MVCLn5pf8LVS+fjRgbgdw3cSYM1h5qD82ZkHFxSujMry/7
         Ndyc6YUJ25FL/B/OXkYu08Qg/NSjzrjY545hTxwlnTpCIfzYv8+IiRGsW8TmYxaRZslm
         zftSdfCWzmFCfgy+021vlLTVJsJ65fYOIIWc4BXXleRgGLU1NHDku7VZqvyF83UsRd8Q
         L49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=hQ4ih0UdB0NOdAJLRyAfFoXRg3IBMsGXrVzfh23+lBw=;
        b=jc/rpwIQr0sE1jfatCt3H8EtwdANwXd60NW9wh7ihxknqxskp9UewZJExDSOsiFK8P
         DypNz1iGd09gCSjp31EziAyaor2OU4R5WXCkDOJ00oGlQX9Y/78qn/9Av8nGFtvq5au8
         D5RIYOiaAyVJh/wIKFJItz7OHW4hRcxYAo8Cl175Vr1jZsxVMgztE9khFsmTXuyX7WTW
         9bghIm94AcqHUuSvPT1fS/JJRE6w9wNZKRmgRY4hjLCI0zBbYAesUJi1AG96JUTfsBva
         7B9mPzu8/sqYFLsO7LsUbKoCtUa9/KYV52ZF6musFR9pST6YA4Ly6ILFevaoKbvce3jA
         az7w==
X-Gm-Message-State: APjAAAXpX686Smb/N57Uga1vMgewnr7/tRUsY3juyr1eoI35jOgKFDm4
        +mqfnHN1bM/KO5XmWfLDE7M=
X-Google-Smtp-Source: APXvYqz8o+KlJqn1byMzAtUGo9da99QfzpXo6QCnXuo7KFC8t5E0GC7zDMVqFmWUuIifqZpw8pqjMg==
X-Received: by 2002:aed:3841:: with SMTP id j59mr9306043qte.220.1581616400083;
        Thu, 13 Feb 2020 09:53:20 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id r6sm1805247qtm.63.2020.02.13.09.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 09:53:19 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 13 Feb 2020 12:53:18 -0500
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        lersek@redhat.com, leif@nuviainc.com, pjones@redhat.com,
        mjg59@google.com, agraf@csgraf.de, daniel.kiper@oracle.com,
        hdegoede@redhat.com, nivedita@alum.mit.edu,
        mbrown@fensystems.co.uk, mingo@kernel.org
Subject: Re: [RFC PATCH 0/3] efi/x86: add support for generic EFI mixed mode
 boot
Message-ID: <20200213175317.GC1400002@rani.riverdale.lan>
References: <20200213145928.7047-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200213145928.7047-1-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Feb 13, 2020 at 03:59:25PM +0100, Ard Biesheuvel wrote:
> This series is another part of my effort to reduce the level of knowledge
> on the part of the bootloader or firmware of internal per-architecture
> details regarding where/how the kernel is loaded and where its initrd and
> other context data are passed.
> 
> The x86 architecture has a so-called 'EFI handover protocol', which defines
> how the bootparams struct should be populated, and how it should be
> interpreted to figure out where to load the kernel, and at which offset in
> the binary the entrypoint is located. This scheme allows the initrd to be
> loaded beforehand, and allows 32-bit firmware to invoke a 64-bit kernel
> via a special entrypoint that manages the state transitions between the
> two execution modes.
> 
> Due to this, x86 loaders currently do not rely on LoadImage and StartImage,
> and therefore, are forced to re-implement things like image authentication
> for secure boot and taking the measurements for measured boot in their open
> coded clones of these routines.
> 
> My previous series on this topic [0] implements a generic way to load the
> initrd from any source supported by the loader without relying on something
> like device trees or bootparams structures, and so native boot should not
> need the EFI handover protocol anymore after those change are merged.
> 
> What remains is mixed mode boot, which also needs the EFI handover protocol
> regardless of whether an initrd is loaded or not. So let's get rid of that
> requirement, and take advantage of the fact that EDK2 based firmware does
> support LoadImage() for X64 binaries on IA32 firmware, which means we can
> rely on the secure boot and measured boot checks being performed by the
> firmware. The only thing we need to put on top is a way to discover the
> non-native entrypoint into the binary in a way that does not rely on x86
> specific headers and data structures.
> 
> So let's introduce a new .compat header in the PE/COFF metadata of the
> bzImage, and populate it with a <machine type, entrypoint> tuple, allowing
> a generic EFI loader to decide whether the entrypoint supports its native
> machine type, and invoke it as an ordinary EFI application entrypoint.
> Since we will not be passing a bootparams structure, we need to discover
> the base of the image (which contains the setup header) via the loaded
> image protocol before we can enter the kernel in 32-bit mode at startup_32()
> 
> A loader implementation for OVMF can be found at [1]. Note that this loader
> code is fully generic, and could be used without modifications if other
> architectures ever emerge that support kernels that can be invoked from a
> non-native (but cross-type supported) loader.
> 
> [0] https://lore.kernel.org/linux-arm-kernel/20200206140352.6300-1-ardb@kernel.org/
> [1] https://github.com/ardbiesheuvel/edk2/commits/linux-efi-generic
> 

As an alternative to the new section, how about having a CONFIG option
to emit the 64-bit kernel with a 32-bit PE header instead, which would
point to efi32_pe_entry? In that case it could be directly loaded by
existing firmware already. You could even have a tool that can mangle an
existing bzImage's header from 64-bit to 32-bit, say using the newly
added kernel_info structure to record the existence and location of
efi32_pe_entry.

Also, the PE header can live anywhere inside the image, right? Is there
any reason to struggle to shoehorn it into the "boot sector"?
