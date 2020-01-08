Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5866E1346C3
	for <lists+linux-efi@lfdr.de>; Wed,  8 Jan 2020 16:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgAHP5D (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Jan 2020 10:57:03 -0500
Received: from mail-qv1-f67.google.com ([209.85.219.67]:34316 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727090AbgAHP5D (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 8 Jan 2020 10:57:03 -0500
Received: by mail-qv1-f67.google.com with SMTP id o18so1616531qvf.1;
        Wed, 08 Jan 2020 07:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=t/UXz8NG4xnRGEkWWnp+LB0XowepG1LsOEgscvBtqw8=;
        b=EJQ8FtDdQTBPrXUSXKgmb8BW+YZGbW61mtfANUOLXYLpyPfxP7A5P6KGEEVbiK94zy
         zVUGP6LIc1FrZGIpJ4S/ZXeje0VekEh9yGO1+VLakKafWLryI4oKB2ik1LwGv0yhF1I5
         ceGl7SC8KzxmjQyJh+2o/NqAKpFhheFQbEjakKMqgATx3TxkYm8yQ/5NBSMVsxRpBpkp
         +HQXhPkeR+P+nNMKgP2JTnal6g0Byi3PWtQNyD+SJt/F4bdhMv8czTX8TtQa7qFLlrum
         mSUgT6hjnM9ul24SDZ1UlQFOktqMhSi0pS7TKbHBr9hcXloyUvKRjuNzauhJQVSyVWSf
         ea9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=t/UXz8NG4xnRGEkWWnp+LB0XowepG1LsOEgscvBtqw8=;
        b=lpfhR3euWxU2GJStxFb5USxWl++4JNaPLjAERwCkJC+nn3NlQ+2vdn6zFBaiDuj2ZF
         3zcPY7ufcHeUd8SJE6TodfIVPSXULfTweM2Ak6yK0Rrcue39NbeeIlyRqyCRY0SPTtbW
         ifR9IP1sHGtnQxHuew4BlQpp/z8vkvMhGBUzmqQlOQAzdhjyTbMsecs6raU0imgqiHbu
         wQTEAmQZYQQ2dLUbLu2iUl/A57HjiUdP7T5VbwF4FyBwYfGOSToItMKarA82Ne6DBPga
         sQx4teJIRUWvXJ/8AGnHEdnkuD/tguMtdMNl2fe1NZ0SDAWuIasfmRFYUhh+Gkx+w+iQ
         uSWg==
X-Gm-Message-State: APjAAAV7TE3ZeM4Hy3WOnmRho7+H87aOXbdDBCssb1d+rEZOzciFysTX
        NK9PzCZPQKDUPfuNs5z6t3o=
X-Google-Smtp-Source: APXvYqy/KEWQlsH9ih86XYm09pFRk+5mRemhYPCGqdvP3frNrtbfAPBfs4zSROyXjiJQeYF8B8GgrA==
X-Received: by 2002:a0c:da08:: with SMTP id x8mr4712828qvj.166.1578499022473;
        Wed, 08 Jan 2020 07:57:02 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id f19sm1534040qkk.69.2020.01.08.07.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2020 07:57:02 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 8 Jan 2020 10:57:00 -0500
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC PATCH 2/3] x86/boot/compressed: force hidden visibility for
 all symbol references
Message-ID: <20200108155700.GA2602122@rani.riverdale.lan>
References: <20200108102304.25800-1-ardb@kernel.org>
 <20200108102304.25800-3-ardb@kernel.org>
 <20200108154031.GA2512498@rani.riverdale.lan>
 <CAKv+Gu8AOukQL3qokt+Rz3PKBRWWnSULGUr=+yxg_HPM8-uodw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu8AOukQL3qokt+Rz3PKBRWWnSULGUr=+yxg_HPM8-uodw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Jan 08, 2020 at 04:47:51PM +0100, Ard Biesheuvel wrote:
> The EFI stub already sets the hidden visibility attribute for the few
> external symbol references that it contains, so it is not needed in
> the context of this series.
> 
> In the future, we can revisit this if we want to get rid of the
> various __pure getter functions, but that requires thorough testing on
> other architectures and toolchains, so I'd prefer to leave that for
> later.

We don't need it for the stub right now, but then this bit in the cover
letter is not yet true, we still need to be careful about libstub code.

> ...we can start using ordinary external symbol references in the EFI
> stub without running the risk of boot regressions.
