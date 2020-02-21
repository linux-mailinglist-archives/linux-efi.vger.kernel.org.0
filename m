Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8A521683BF
	for <lists+linux-efi@lfdr.de>; Fri, 21 Feb 2020 17:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgBUQjV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 21 Feb 2020 11:39:21 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:41195 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgBUQjU (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 21 Feb 2020 11:39:20 -0500
Received: by mail-qv1-f68.google.com with SMTP id s7so1244627qvn.8
        for <linux-efi@vger.kernel.org>; Fri, 21 Feb 2020 08:39:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ecyiYn0S98TeK8DtIEusSgfssO6pktR0qW764uttG+g=;
        b=Qj9GOuU5+6KuKia/7b5C7x9LA61axcp+bbf+slwbTb0wY78MxNyHQAe1PhAqOyslXQ
         ZlKO6HU9zwTf/J4wOlbbcehj5ldH3ul2MIQ4bi29GjDq2owOEXG9k3LTkkbJKG/AScvh
         k0G+0Cr2vjPhVt+9XU1QhLSa0ilPPUlUEumkdyR4p1B+BijhC1onNSWugX1ww8a17mth
         fSxhfuWpZwIorHrAefPD+jVwDVjmPPAL67pDvDZxwjFGVXOmkSdOmtUCWoHRi9vt6Le7
         vMPVNFyWXZQXhQq1/Kc2GMaH6CG4mY/c5w6DEiLkQDHLoKMpl4k82lSs3ImTsw5AFYgH
         Ssqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ecyiYn0S98TeK8DtIEusSgfssO6pktR0qW764uttG+g=;
        b=HD+qM7VeFjkklGdSEqRzXbyhiGrvrph083cI1h2+vz1xNcO93Al2YJpKzDpW6rIZWk
         dzAPyIwo5tEwokD0z4bnCOvxOQOx96HTetVThxrIM9z4D/2n5W/zTyoKgygHthzkZdps
         AhK6feDTtoEkEu8phdmhJErczI7gnYnDtwVckYGT4O7FAEzFxQXoAAhvC4S6cQmllN0v
         mJEePbpW73ppf3B1FQbE1briraIo+5E71wyheVCs1ijWhTl+BYLKbGj6qmeJeKeWO7C6
         I4T3UJUBiAtBA1XMPaceCOHrWxx7c3NzZa5Kuj+44E9t4EqDEukM6OWuio1/YifG1nBH
         BivA==
X-Gm-Message-State: APjAAAXtLPUQ0Mgvk1H7f0e3//gAyHKsD+IFiA1OpVsQbAGVT6CZQV7q
        aDPmKpOdFCbtzJtMr6N0xoQ=
X-Google-Smtp-Source: APXvYqwf598FFI1ES1udl6WTtj43kcQAHRXToAVvYJ/c2pzLJLNDpT09KPmaz/J+YD7HvK5UKbIW6A==
X-Received: by 2002:ad4:4e09:: with SMTP id dl9mr31069643qvb.137.1582303158074;
        Fri, 21 Feb 2020 08:39:18 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id y197sm1717648qka.65.2020.02.21.08.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2020 08:39:17 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 21 Feb 2020 11:39:16 -0500
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, lersek@redhat.com, leif@nuviainc.com,
        pjones@redhat.com, mjg59@google.com, agraf@csgraf.de,
        daniel.kiper@oracle.com, hdegoede@redhat.com,
        nivedita@alum.mit.edu, mingo@kernel.org
Subject: Re: [PATCH v2 4/5] efi/x86: Implement mixed mode boot without the
 handover protocol
Message-ID: <20200221163915.GA2766905@rani.riverdale.lan>
References: <20200217144822.24616-1-ardb@kernel.org>
 <20200217144822.24616-5-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200217144822.24616-5-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Feb 17, 2020 at 03:48:21PM +0100, Ard Biesheuvel wrote:
> Add support for booting 64-bit x86 kernels from 32-bit firmware running
> on 64-bit capable CPUs without requiring the bootloader to implement
> the EFI handover protocol or allocate the setup block, etc etc, all of
> which can be done by the stub itself, using code that already exists.
> 
> Instead, create an ordinary EFI application entrypoint but implemented
> in 32-bit code [so that it can be invoked by 32-bit firmware], and stash
> the address of this 32-bit entrypoint in the .compat section where the
> bootloader can find it.
> 
> Note that we use the setup block embedded in the binary to go through
> startup_32(), but it gets reallocated and copied in efi_pe_entry(),
> using the same code that runs when the x86 kernel is booted in EFI
> mode from native firmware. This requires the loaded image protocol to
> be installed on the kernel image's EFI handle, and point to the kernel
> image itself and not to its loader. This, in turn, requires the
> bootloader to use the LoadImage() boot service to load the 64-bit
> image from 32-bit firmware, which is in fact supported by firmware
> based on EDK2. (Only StartImage() will fail, and instead, the newly
> added entrypoint needs to be invoked)
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

I think there's one issue with this. startup_32 is 14KiB from the start
of the image because of .setup. This means the code in startup_32 that
rounds the load address up to kernel_alignment will likely calculate it
as 2MiB from the image address (if the image address was 2MiB-aligned),
and the page tables constructed by the 32-bit code will be beyond the
space allocated for the image.

I think the simplest fix would be to increase SizeOfImage by
kernel_alignment to allow enough slop space for the alignment. We should
also increase it by text_start, since we need init_size beginning from
startup_32, not from the image address.
