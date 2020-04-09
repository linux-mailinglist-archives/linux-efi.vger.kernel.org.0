Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4CC1A3BAB
	for <lists+linux-efi@lfdr.de>; Thu,  9 Apr 2020 23:08:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbgDIVIu (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 9 Apr 2020 17:08:50 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44963 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727242AbgDIVIu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 9 Apr 2020 17:08:50 -0400
Received: by mail-qt1-f193.google.com with SMTP id w24so1160214qts.11;
        Thu, 09 Apr 2020 14:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JAFZ7dRQi+ZOH9Y8t0oetajrdlB2KVsPn/jdlE5Lqu8=;
        b=h1nvXDASszQ1WwOt9WNXBoOojysLq8SkPN5wJWJ4DGeIkbwZ93UTMZbWZ2GPgBQHdX
         ijBQhLAtvQx8D5+z8xJmCwupRrOeVnzKUDFcYnW9O0I5xuGAIjTju2d1kMiGp6wH9NeF
         hV/unsWb8/7q44lH7/dJMTsuKfhY6AClitGR/GrnxeeqnshYYT845hWAfihecRYSNhtd
         /SMjcBIFUNc1RBOaMSHNvj6EMgV2pt4nPcLMdE7psHhV1zxkWf0vNBZA6Buu5BoSu+6z
         XDpeznLmHXTpjHPpvJbmSnu7zoIsMxKTE/m9gGjvQp8GJvDG3QgqbWDSQYnFCdYBH2Jn
         dm0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=JAFZ7dRQi+ZOH9Y8t0oetajrdlB2KVsPn/jdlE5Lqu8=;
        b=I+Uho8fXe0X8DUWi9dyDWh1Ns6zLQklCkSaNOVHryC9dk3ik/xiDQy/9tBbYuxCQLF
         Wb++5Drk71PhhQJctFL2Gds6PzUxCtPmx2NJKn1Z0RLiXYCOHGhH/GpE5MZXAgGFxtu0
         lzcKKpecEGsHOxd+m3xQDjycwx1cdA3vI5u8J/DQDb0+Wx30d7GdtoB/p3AfgXlkATcN
         Q6PcGOR9vQ4XrpWcGWLBAOteBTM2QTuXD3oqbFVI9b7A+vltDSs4H7O/ThlviOSdXaNV
         gjQQkaCPXzqcXK6Y2ebxv+vwuXHJGNFdysrrqIvjxTRnKv4xGtxeDQLTYJC5As2tcgpj
         7erQ==
X-Gm-Message-State: AGi0PuYDDJKO2L199p6TPYUIy+siaq+WJDLqY/E4IUEN48tkaLEa6fjA
        RJr781IcI3BESYEs8cJqd3g=
X-Google-Smtp-Source: APiQypKUI8F7x+uXX0jMQDWk+uGhTnngIA1mZuj8V8As/1y8qQui6+b8jgX+ZoSRuGYgYDl1OTw0pg==
X-Received: by 2002:ac8:4a98:: with SMTP id l24mr1407893qtq.223.1586466529986;
        Thu, 09 Apr 2020 14:08:49 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id h11sm41075qtr.38.2020.04.09.14.08.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2020 14:08:49 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 9 Apr 2020 17:08:47 -0400
To:     Brian Gerst <brgerst@gmail.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Borislav Petkov <bp@suse.de>,
        Colin Ian King <colin.king@canonical.com>,
        Gary Lin <glin@suse.com>, Jiri Slaby <jslaby@suse.cz>,
        Sergey Shatunov <me@prok.pw>, Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH 3/9] efi/x86: Move efi stub globals from .bss to .data
Message-ID: <20200409210847.GA1312580@rani.riverdale.lan>
References: <20200409130434.6736-1-ardb@kernel.org>
 <20200409130434.6736-4-ardb@kernel.org>
 <CAMzpN2gJWwVun1Kp6vGuza9LM5KpB=0EwsP8x8eOJQuDGh38Hg@mail.gmail.com>
 <CAMzpN2jFbf8k99pWaTYRBmSB+iNAKYsufjEhqO6Vv0qxAcHyGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMzpN2jFbf8k99pWaTYRBmSB+iNAKYsufjEhqO6Vv0qxAcHyGA@mail.gmail.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Apr 09, 2020 at 04:53:07PM -0400, Brian Gerst wrote:
> > Can we use the -fno-zero-initialized-in-bss compiler flag instead of
> > explicitly marking global variables?
> 
> Scratch that.  Apparently it only works when a variable is explicitly
> initialized to zero.
> 
> --
> Brian Gerst

Right, there doesn't seem to be a compiler option to turn off the use of
.bss altogether.
