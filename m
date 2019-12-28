Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A760212BCE2
	for <lists+linux-efi@lfdr.de>; Sat, 28 Dec 2019 07:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbfL1Gff (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 28 Dec 2019 01:35:35 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:43837 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbfL1Gff (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 28 Dec 2019 01:35:35 -0500
Received: by mail-qk1-f194.google.com with SMTP id t129so22939292qke.10
        for <linux-efi@vger.kernel.org>; Fri, 27 Dec 2019 22:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nZ8onEKn9qBmgxCL/WHku5+COjxuEn7Ue0xL0gB/QBY=;
        b=AXm6o1X4jpJx+brRhqbRlRkZr1+yBDX0Ytt3kslwg2kpIg+CfZyYoAAmUOE+NGP1mE
         abrFyzIInp3vZMK87icfab+l0sXo2cljmZ0dybeSe+IfHaMrEDqqHoms+D/57UVFhoYf
         FLSkv91e7vCS2jbmrQdlgJi3z7XQi5X9Kz0v9RXIuWhXQ8jhQJ8b/Htfnxaeg31cQIYt
         DL8+RuIUAwondhWLq+Yp6RJ0YBzzYR1qkoU8ScuTF3i+oxOb6NiJ/matjwy60E93Wjr8
         y+YiFw6jinQXFQtX+xMW9HMauJuVnzKbb84Ge/v/wwe2d9leQg/IKNgezJ8iIlXP3+hM
         cqMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=nZ8onEKn9qBmgxCL/WHku5+COjxuEn7Ue0xL0gB/QBY=;
        b=roHkE13cRp9492JaBtX5WN+dgptoYk5y4V8pLyEgTYFu/Y9Af5sXmIMpcZN4/rartI
         r8fmBT8chaW3CbAXpbdjdF61LHAyc6HhFQKtbUxwKIJpNcgrhXjSOgmFW5a8TXBTuZjg
         RyyQPVEuA0QBTzGe5yS9nPFC+ygnBcBZwgiVzFfISva2toVl2NukluZzp7dSrnlKM4Tm
         h+SYaXb/kKoOf2INTCsnRO/TcU7gWdw5MyFZ74jkY8X2LvKh6yX7xPMpd8hJDEp1h/ev
         JEoXfSqLuM2neM3rTN4yMAdmWknrsNqW6Z5YhIIx+mMUWB+8EOR76L9T9qn0qbsVCcJZ
         tJCg==
X-Gm-Message-State: APjAAAWKAJiaA6HjunXt6+Km53lKOOyz5E6W/Iv+vLVcr29Av4qyvLbi
        52YUHvlW6/xVsdazRNjb+Ctr9f1f
X-Google-Smtp-Source: APXvYqw0Rpm+eiVwT5LTyl4lZtF4EVAAuDZ31zvdwui4ihWOsfe4nEAuvtNAbsBmSxGstddJdkMJEA==
X-Received: by 2002:a37:5841:: with SMTP id m62mr45624488qkb.256.1577514934454;
        Fri, 27 Dec 2019 22:35:34 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id l62sm10467880qke.12.2019.12.27.22.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2019 22:35:33 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Sat, 28 Dec 2019 01:35:32 -0500
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH 1/3] efi/x86: simplify 64-bit EFI firmware call wrapper
Message-ID: <20191228063531.GB1194635@rani.riverdale.lan>
References: <20191228044357.GA1194635@rani.riverdale.lan>
 <F8539C65-87F2-460C-A3CB-474C4D1BC08B@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <F8539C65-87F2-460C-A3CB-474C4D1BC08B@amacapital.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Dec 28, 2019 at 01:29:00PM +0800, Andy Lutomirski wrote:
> 
> > * The stack must be 16-byte aligned
> 
> Nope. The asm needs to do this for runtime services. The kernel runs with 8-byte stack alignment.
> 
32-bit code is actually only 4-byte aligned in the kernel proper, right?

Currently, only native 64-bit calls always respect the 16-byte alignment
requirement, by aligning explicitly in the asm stubs, or after the
cleanup patches, via the efi bootloader running with 16-byte stack
alignment.

I think mixed mode might actually be aligned via the asm stub in the
kernel proper, though it doesn't look like it is in the bootloader
portion.
