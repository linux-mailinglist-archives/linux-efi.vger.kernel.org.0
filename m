Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3E71745DD
	for <lists+linux-efi@lfdr.de>; Sat, 29 Feb 2020 10:24:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgB2JYb (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 29 Feb 2020 04:24:31 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42820 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbgB2JYb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 29 Feb 2020 04:24:31 -0500
Received: by mail-wr1-f68.google.com with SMTP id p18so6075200wre.9;
        Sat, 29 Feb 2020 01:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RgPJE0orJQVDrDLEaPJ8R2RxW8F5htMBVkLJo9I+3vI=;
        b=o9rkUgC3sZYDJqLH0G98KAbq5NAH7w8L5tbrS2uN5TzpAoyRCzhVio6e2iwYrB13dY
         xHsrTSzVBewKcPJcBcLzDrgOToNImEQeZ9joKizsBvGASOzPAiW8/NWryBSUuGRig3Gu
         NW2y73yAVN4drVh9it/+OBI0+f7gcI7ZM4Y/oiyKjLMWsAYlrMTv+XgxrdYFQ+fxT9tr
         n0aG94hIH5s6TkVWYbIlamSVDTv2ES+8PkP3zujOXMJ38DcbXtkIt4HCcpsjUcajFbY4
         JjFcnwg7F8iJT1AT8g6lvnSohzgu6kTK9M6zQqr40j1ST8e7grDp2i6htBLXaxgQH9Wv
         x1nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=RgPJE0orJQVDrDLEaPJ8R2RxW8F5htMBVkLJo9I+3vI=;
        b=jOPr61QL0QiUaEzpPuWwmFKstJ1f+Ll3dj4VA+os+ppsN85rOuOX6Gz0g0Fd+NN54r
         QK6rC/kUOsZaBa9WPWh6GLlrVufwT6BvaJf2qisGvWis/E/rGZ3f9Z+XUKRD2+iMD1Ha
         I9oBDq9e8f0PCykDzzkyR34qslLkLUEv8z8YRdCJ5tuJUqW2SvM6QeFbHAw8qCbhjhuC
         VK6OfPIdhiGk8x2YDYMhOHyXU3/58h6jVsDFl4mteSzQBqPM0Q4GL9S9QBbc3zIDiw5N
         jRBKj8dYeq2RsxH18GU8WvTNiQ3Jm4hmi7nGMp95dj1/uQ7nRVi2oj4YUSdXd/65mEwv
         h67A==
X-Gm-Message-State: APjAAAWcZemcRXjr2pvPCdzjycZslsa9ABUJyFbXZRc0kS58NRLxcgCw
        qRRG34f9ht9c/BC0bT4vIf4=
X-Google-Smtp-Source: APXvYqypQZFf++sh1JdwJcb+KL95+X3s+ht196vQUdpvCNcMCeFhfMHU9OUnkaQTMr1064b6VZ1vPA==
X-Received: by 2002:a5d:4384:: with SMTP id i4mr5183282wrq.396.1582968268971;
        Sat, 29 Feb 2020 01:24:28 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id p17sm14011569wre.89.2020.02.29.01.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Feb 2020 01:24:27 -0800 (PST)
Date:   Sat, 29 Feb 2020 10:24:25 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v2 1/1] x86/boot/compressed: Fix reloading of GDTR
 post-relocation
Message-ID: <20200229092425.GB92847@gmail.com>
References: <20200226204515.2752095-1-nivedita@alum.mit.edu>
 <20200226230031.3011645-2-nivedita@alum.mit.edu>
 <20200227081229.GA29411@gmail.com>
 <20200227151643.GA3498170@rani.riverdale.lan>
 <CAKv+Gu8BiW6P6Xv3EAPUEmbS3GQMJW=eRr-yygRbForaGDQyyw@mail.gmail.com>
 <20200227155421.GA3507597@rani.riverdale.lan>
 <CAKv+Gu-k0c8GzKysv4Z9tYzEvfhJUzuiKx5nfwD0JU8ys=LZdg@mail.gmail.com>
 <20200227180305.GA3598722@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200227180305.GA3598722@rani.riverdale.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


* Arvind Sankar <nivedita@alum.mit.edu> wrote:

> On Thu, Feb 27, 2020 at 06:47:55PM +0100, Ard Biesheuvel wrote:
> > 
> > Interesting. I am going to rip most of the EFI handover protocol stuff
> > out of OVMF, since it is mostly unnecessary, and having the PE/COFF
> > loader put the image in the correct place right away is a nice
> > complimentary improvement to that. (Note that the OVMF implementation
> > of the EFI handover protocol does not currently honor the preferred
> > address from the setup header anyway)
> 
> Yeah, for my testing I'm running the image from the EFI shell, which
> enters via PE entry point and honors the pref address.

So with KASLR, which is the distro default on most x86 distros, we'll 
relocate the kernel to another address anyway, right?

But telling the bootloader the preferred address would avoid any 
relocation overhead even in this case, right?

Thanks,

	Ingo
