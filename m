Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30009117543
	for <lists+linux-efi@lfdr.de>; Mon,  9 Dec 2019 20:12:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726589AbfLITMq (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 9 Dec 2019 14:12:46 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34291 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbfLITMq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 9 Dec 2019 14:12:46 -0500
Received: by mail-qk1-f196.google.com with SMTP id d202so14129036qkb.1;
        Mon, 09 Dec 2019 11:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=q2n3Ep3oTE0Cvd+RIe5uHUhooskIBzQpsbGGxGO3Chk=;
        b=mOBkGJs+38FH69k+F7+s119d8qSe86/v7VrixRpQhmiBBj7z/n2jAeIMjE0pnagRjY
         6R9W1S5UYd7sagDHr9/SW2+SN+rNkp63Dg9qTPP0dAg3LNHbEYbUHgB7IQbjWYjXyIyn
         Bi7zbwed108OaMBZ+QJRZJp9ialxwYt7gwbeV31gnABXV6FRu85ASppn0ecWefBt+cxg
         WOQ5G30lzC1duAlaipqaecjxBgGl9ogRnHkdlCzoWANSJk0SIC1CcfVApvVWlb61fJBa
         bcYQPp02ZTPo9skJMoxd3hDbLc6iCml/jMOeeegDk75vuaUX5qu0TMmIl+VpFzwdfW7B
         2WKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=q2n3Ep3oTE0Cvd+RIe5uHUhooskIBzQpsbGGxGO3Chk=;
        b=dPoK+S0oRJhShRBsgDI4Ce+QiaRxmDz+klp+gbsaFo5kiJXNCNf1XF/Ukgc0FVMW6a
         JCec29x752Qy40UGFyv7YxWWR5Ks7Ci3FcGq7+ChMoKUQc+YwzWuUXOOfMzRCypwfBwD
         QYwBpOwwjQ/VWFkVkCgp76iEJFURFnDwV73tIpLeCOAfqyoNKjchanC7xaytWMNg6eXO
         I+I0N/lYqTiTVensZeL5mv+wq4rbajaOx/FQNa3+WZ+xfgGSBwFzPIQ2gSqjhdxvfXpY
         uye55ZZX6sOjjqJfEdHLgx+Q8I93QfhyTh0mys7NxRygD3bOm9FVxw9JmPwIrdOYjdeH
         qQnA==
X-Gm-Message-State: APjAAAUTfiAZaUJasWtrwPYnaVH7Qgl/5V0ZhEIlseWcm7bN4s/z+J+G
        0Sq3OJ7U4j2WavCxSxZxh/k=
X-Google-Smtp-Source: APXvYqzieak4udGQsL5U1LHgU7o/hQRs0IaSDXl7JFWCmqe0v+TRHhSL6p4TUPtXh5v3iZSdTs/k2A==
X-Received: by 2002:a37:5b41:: with SMTP id p62mr4897197qkb.442.1575918764987;
        Mon, 09 Dec 2019 11:12:44 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id y26sm176564qtc.94.2019.12.09.11.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2019 11:12:44 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Mon, 9 Dec 2019 14:12:42 -0500
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
Subject: Re: [PATCH 6/6] efi/earlycon: Remap entire framebuffer after page
 initialization
Message-ID: <20191209191242.GA3075464@rani.riverdale.lan>
References: <20191206165542.31469-1-ardb@kernel.org>
 <20191206165542.31469-7-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20191206165542.31469-7-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Dec 06, 2019 at 04:55:42PM +0000, Ard Biesheuvel wrote:
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> When commit 69c1f396f25b
> 
>   "efi/x86: Convert x86 EFI earlyprintk into generic earlycon implementation"
> 
> moved the x86 specific EFI earlyprintk implementation to a shared location,
> it also tweaked the behaviour. In particular, it dropped a trick with full
> framebuffer remapping after page initialization, leading to two regressions:
> 1) very slow scrolling after page initialization,
> 2) kernel hang when the 'keep_bootcon' command line argument is passed.
> 
> Putting the tweak back fixes #2 and mitigates #1, i.e., it limits the slow
> behavior to the early boot stages, presumably due to eliminating heavy
> map()/unmap() operations per each pixel line on the screen.
> 

Could the efi earlycon have an interaction with PCI resource allocation,
similar to what commit dcf8f5ce3165 ("drivers/fbdev/efifb: Allow BAR to
be moved instead of claiming it") fixed for efifb?
