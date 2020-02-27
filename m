Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3DF17220A
	for <lists+linux-efi@lfdr.de>; Thu, 27 Feb 2020 16:16:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729235AbgB0PQt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 27 Feb 2020 10:16:49 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43388 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729174AbgB0PQt (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 27 Feb 2020 10:16:49 -0500
Received: by mail-qk1-f196.google.com with SMTP id q18so3425977qki.10;
        Thu, 27 Feb 2020 07:16:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WlXFvdOo+6yWEzwT1XC3KPZhgv50NpBAuaNpJg/kpbM=;
        b=VpCvudHLe5sWCh9mziPxV5NeC851zU5dJsWYAZEIhc3JENeYiezxfqhDKx094w2Wer
         5V3gG3tQJ58w/mXV66o8VptoCjEG0hj0dH0fc8j+XhGsx2V86L24P2wttxmgmX+WBtXa
         MUQ02A4MJM6IrmdsY9ME3yj/YNAOAj3PDMKXWTMEqpw8sy+KZszp+BoCokoKze/piumn
         Cz3XAqs2/svBXcZyQmDrhv1LFvBpkvFU75j1JhtwFRQVfYIPPtLo3Q3J1gDhwI44Gdk+
         DAgzv3soAm0+koay1uVZoyWn9fEwLHlWvmyE1VanYLACi5AJrvoHIEDnEQ6JkuhQQ4Yl
         bGpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=WlXFvdOo+6yWEzwT1XC3KPZhgv50NpBAuaNpJg/kpbM=;
        b=YmDgcqvKfQ+aWCIsRdQ68CAcHtA45HnMasD9el7NVD4XsFXconPJPeKygozXBjEvEW
         ZnvMMv8xwl0ctI/H7irsmtgX/ud4v38XqxUT3GKfz1rlDOoas2Abrw+Orxk6jJKABNay
         JSQfynZCfqgCFQ6ojXRt2NPBwg6snQJQB5AVz9AJhSZMX+KKM3kx8RYJ1U0UEPmABcE1
         R8Z398DqQ0rocf80ZzdVFsGFuk8Vl+WAgP/izMZAWNLmbVYq8ymkqpRNju1eFPy1hBB7
         2nL16WjTi0Wj9nEtxlAsy3HF8UWFk8+CmAkUSGKubX9HYtddMzNaTplX4gHAeKjz/mMY
         E29Q==
X-Gm-Message-State: APjAAAUh/p7HcGUglicelL9VtwVCkv4k1vypPVQYsON/KxZARyMzPGL8
        X0gTrU2EEOUigPUAHN8W3vo=
X-Google-Smtp-Source: APXvYqydyeYbPfvW/fT2dGAODJsMyzYunJhM9o9M/BQXIedYNACpqv5xfiScE0YCcHIkUy0ONOV8UA==
X-Received: by 2002:a37:f502:: with SMTP id l2mr5484725qkk.76.1582816606616;
        Thu, 27 Feb 2020 07:16:46 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id m6sm3291361qki.24.2020.02.27.07.16.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 07:16:46 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 27 Feb 2020 10:16:44 -0500
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 1/1] x86/boot/compressed: Fix reloading of GDTR
 post-relocation
Message-ID: <20200227151643.GA3498170@rani.riverdale.lan>
References: <20200226204515.2752095-1-nivedita@alum.mit.edu>
 <20200226230031.3011645-2-nivedita@alum.mit.edu>
 <20200227081229.GA29411@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200227081229.GA29411@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Feb 27, 2020 at 09:12:29AM +0100, Ingo Molnar wrote:
> 
> * Arvind Sankar <nivedita@alum.mit.edu> wrote:
> 
> > Commit ef5a7b5eb13e ("efi/x86: Remove GDT setup from efi_main")
> > introduced GDT setup into the 32-bit kernel's startup_32, and reloads
> > the GDTR after relocating the kernel for paranoia's sake.
> > 
> > Commit 32d009137a56 ("x86/boot: Reload GDTR after copying to the end of
> > the buffer") introduced a similar GDTR reload in the 64-bit kernel.
> > 
> > The GDTR is adjusted by init_size - _end, however this may not be the
> > correct offset to apply if the kernel was loaded at a misaligned address
> > or below LOAD_PHYSICAL_ADDR, as in that case the decompression buffer
> > has an additional offset from the original load address.
> > 
> > This should never happen for a conformant bootloader, but we're being
> > paranoid anyway, so just store the new GDT address in there instead of
> > adding any offsets, which is simpler as well.
> > 
> > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > Fixes: ef5a7b5eb13e ("efi/x86: Remove GDT setup from efi_main")
> > Fixes: 32d009137a56 ("x86/boot: Reload GDTR after copying to the end of the buffer")
> 
> Have you or anyone else observed this condition practice, or have a 
> suspicion that this could happen - or is this a mostly theoretical 
> concern?
> 
> Thanks,
> 
> 	Ingo

Right now it's a theoretical concern.

I'm working on another patch, to tell the EFI firmware PE loader what
the kernel's preferred address is, so that we can avoid having to
relocate the kernel in the EFI stub in most cases (ie if the PE loader
manages to load us at that address). With those changes, the required
adjustment won't be init_size - _end any more, and while fixing it up
there, I noticed that it could already be the case that the required
adjustment is different.

Thanks.
