Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 117591A47C9
	for <lists+linux-efi@lfdr.de>; Fri, 10 Apr 2020 17:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgDJPQQ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 10 Apr 2020 11:16:16 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43610 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgDJPQQ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 10 Apr 2020 11:16:16 -0400
Received: by mail-qt1-f193.google.com with SMTP id z90so1645759qtd.10;
        Fri, 10 Apr 2020 08:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D64JTxFboE8mFwIjqdlJP9TLgs55mqV5wx+i2VxI4xs=;
        b=UqRCVASoPnub4LyDAu15e/h8CeC8JETnbSBWW7T1DAygSY7amVYVimD5WZAIvgZxu5
         F7ZQX40cGvLBfNGujHTLqGeJi3NGGqAIz+xiyFrH9slB1B71ADss+04/RV0cJNsr+se+
         mj42xs5u+WEcBbz2MTdCQx2RW+fd7Nxoaa8cJOitbVmU8n+WDcK2Cp5NH4Us2aXAsZ27
         7I4QVfZ6dFxWU9JXY8jTx5DZgL98kr7G7Q2lILVNWwF7fUENnFIE/W42hefO7aCdGsB4
         H/NsBWd/u8Rh+2ok8hcy9AkDvLQC0pEeSYO8muzqrCZq66WV0B3nQVKfz+TqMSA8FMhy
         Tclw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=D64JTxFboE8mFwIjqdlJP9TLgs55mqV5wx+i2VxI4xs=;
        b=lNUwCT1S9euyosHQbRIAmrrGjVHBpBV48o3/nH0xxpNw7P+A5b7GJQSIQAKNQfYBzL
         txXUeWbONRQElZMPPnp4NtpgaI7PbgSYXD/sCn0h+Qw/LnBji9CENWwIqCxiCn+4i63M
         ECdQ4Fpt+bM7ygKJuqwj06iLdMdMomD4Ba9jLKhco9EfWUxKlsQEyBg6UK2qFFdnaWJW
         ckpN5pwxKBHKC2yszqwPBALZgsR5MCanF3AxZYlSMXCBS91GK04bk44MZEEgd7cNIgfk
         f+6jNewb5wFyFs9qW5EZJRBIIZ5BABr1LgMagdEC0U7D7Re42tTZCwBQWm5H3wKMpbw3
         AIRw==
X-Gm-Message-State: AGi0PubNS9b858FjXEQHprKaDlxJzuaNSvx8Bqx9aYRp7Qbd8wCnSonz
        1L6nIj7KMvkzNhnpC9/X7V0=
X-Google-Smtp-Source: APiQypJujIWnUDhAAon7+6nh3Zmm6nS4uCtz4e8JnVSu/AMkEIUkyvQYTxAnqPOSQrmHrf6UdzFBDw==
X-Received: by 2002:aed:2625:: with SMTP id z34mr4836442qtc.70.1586531774572;
        Fri, 10 Apr 2020 08:16:14 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id q11sm1820462qkq.109.2020.04.10.08.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 08:16:13 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 10 Apr 2020 11:16:12 -0400
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Brian Gerst <brgerst@gmail.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@suse.de>,
        Colin Ian King <colin.king@canonical.com>,
        Gary Lin <glin@suse.com>, Jiri Slaby <jslaby@suse.cz>,
        Sergey Shatunov <me@prok.pw>, Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 3/9] efi/x86: Move efi stub globals from .bss to .data
Message-ID: <20200410151612.GA970420@rani.riverdale.lan>
References: <20200409130434.6736-1-ardb@kernel.org>
 <20200409130434.6736-4-ardb@kernel.org>
 <CAMzpN2gJWwVun1Kp6vGuza9LM5KpB=0EwsP8x8eOJQuDGh38Hg@mail.gmail.com>
 <CAMzpN2jFbf8k99pWaTYRBmSB+iNAKYsufjEhqO6Vv0qxAcHyGA@mail.gmail.com>
 <20200409210847.GA1312580@rani.riverdale.lan>
 <CAMj1kXFhtK=FRDKBE5OtenNEtpK=kVwyo+0nqJZ_K80RmtYxEg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXFhtK=FRDKBE5OtenNEtpK=kVwyo+0nqJZ_K80RmtYxEg@mail.gmail.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Apr 10, 2020 at 10:20:42AM +0200, Ard Biesheuvel wrote:
> On Thu, 9 Apr 2020 at 23:08, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Thu, Apr 09, 2020 at 04:53:07PM -0400, Brian Gerst wrote:
> > > > Can we use the -fno-zero-initialized-in-bss compiler flag instead of
> > > > explicitly marking global variables?
> > >
> > > Scratch that.  Apparently it only works when a variable is explicitly
> > > initialized to zero.
> > >
> > > --
> > > Brian Gerst
> >
> > Right, there doesn't seem to be a compiler option to turn off the use of
> > .bss altogether.
> 
> Yeah. I'll try to come up with a way to consolidate this a bit across
> architectures (which is a bit easier now that all of the EFI stub C
> code lives in the same place). It is probably easiest to use a section
> renaming trick similar to the one I added for ARM (as Arvind suggested
> as well, IIRC), and get rid of the per-symbol annotations altogether.

Does that work for 32-bit ARM, or does it need to be .data to tell the
compiler to avoid generating GOT references? If that's fine, we don't
actually need to rename sections -- linker script magic is enough. For
eg, the below pulls the EFI stub bss into .data for x86 without the need
for the annotations.

diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index 508cfa6828c5..e324819c95bc 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -52,6 +52,7 @@ SECTIONS
 		_data = . ;
 		*(.data)
 		*(.data.*)
+		drivers/firmware/efi/libstub/lib.a:(.bss .bss.*)
 		_edata = . ;
 	}
 	. = ALIGN(L1_CACHE_BYTES);
