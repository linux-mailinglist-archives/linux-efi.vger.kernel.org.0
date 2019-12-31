Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F14E812DAA7
	for <lists+linux-efi@lfdr.de>; Tue, 31 Dec 2019 18:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbfLaRhB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 31 Dec 2019 12:37:01 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:38764 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727070AbfLaRhB (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 31 Dec 2019 12:37:01 -0500
Received: by mail-qt1-f194.google.com with SMTP id n15so31986115qtp.5
        for <linux-efi@vger.kernel.org>; Tue, 31 Dec 2019 09:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ebdaOQNf66wazXwQzzj1gKYhsFmOlMY5l10phxJBtEc=;
        b=JP5NQk98rjvAwve04+WEDBZqcMXA+ha+R0yZic4CFir3I9dTsQj4GTXVZ79qE614tb
         agRiIXSK2ToWYGPqWDA75KOg13e4U7YVSeA+nvTgsQOaqGosiJb/o0Inl3nDNChqW4KV
         eatEVKEegpwJRpl/4bFNPHnjZS/ZlkS9P7oa/jE+5lslRyonasJ4BacZVNY9dnj7/YDI
         glyyb9AWP06US9HX0JScWvlnigNEUmPqsNAPXtFkr+xgx226EWuoKwqrjoC//8qSzqRY
         k73PO400cWKGEXQWpvVAtAqktMQtTFZlbueL0Hr46q3rMJidSKUbrSdITH0ALHH2JvP1
         FcuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ebdaOQNf66wazXwQzzj1gKYhsFmOlMY5l10phxJBtEc=;
        b=gHO5RIJXXetLZ25CZ4lLZiJor7w6h/kAN529WicSOnR7BlMu23+Y5tyrhR4qFv26mN
         uubg3VdgpEDJsKxhs3aPymg6DN6WnNLVMG5uuSeR2EpybKA4sqfFQn/Iq2ivrWJYRXC7
         2iCoZfKx5wv43dq7FCtm9JSwpOTxyPAzw2QeGLWhydopRP13i1Oj5Wwedt8c00CGiKPy
         VrtmxY9px9HA16MUFwzqub3+BkIevof0fqXpKhN841shSxzUhtdXMF0MC3rj5evF+N9w
         s0au41vpdg5JN4r1CP4GYPaDXKURV2+hd1CNgAzXs/RN0rlRFc3s/6KgxwCibobguVms
         AC5A==
X-Gm-Message-State: APjAAAWlmczA5eQAjFNJDKX5RFrJ3W4hLDQ3ZaJIa3X+42ox9dziQVL+
        Mq849WITXqSOOZ7SOMIxxAw=
X-Google-Smtp-Source: APXvYqwLikBVshz/Cbtke+k0oz0A2ZFXxyfJyU3z0prN7QHBNiYW5tnwjGyuC3wIH9+F4wfgs/qu4Q==
X-Received: by 2002:ac8:540d:: with SMTP id b13mr51451487qtq.244.1577813819920;
        Tue, 31 Dec 2019 09:36:59 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id z8sm15109528qth.16.2019.12.31.09.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Dec 2019 09:36:59 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 31 Dec 2019 12:36:57 -0500
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Ard Biesheuvel <ardb@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Matthew Garrett <matthewgarrett@google.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH v2 18/21] efi/libstub: use 'func' not 'f' as macro
 parameter
Message-ID: <20191231173657.GA4031539@rani.riverdale.lan>
References: <20191218170139.9468-1-ardb@kernel.org>
 <20191218170139.9468-19-ardb@kernel.org>
 <20191231165136.GA3978784@rani.riverdale.lan>
 <CAKv+Gu9yd83-gRp8zGx5A1AcXPMyteRd6oyqgMYv=h5zJjnAaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu9yd83-gRp8zGx5A1AcXPMyteRd6oyqgMYv=h5zJjnAaw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Dec 31, 2019 at 06:06:33PM +0100, Ard Biesheuvel wrote:
> On Tue, 31 Dec 2019 at 17:51, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Wed, Dec 18, 2019 at 07:01:36PM +0200, Ard Biesheuvel wrote:
> > > Use 'func' as the macro parameter name for the efi_call() macros
> > > which is less likely to collide and cause weird build errors.
> > >
> >
> > For my education, what are the possible collisions/build errors that might happen?
> >
> 
> I was concerned about variables called 'f' being passed as one of the
> arguments, but now that I think of it, I'm not sure how that could
> break.
> 
> In any case, I'd like to keep this patch since it also increases legibility.
> 

No objections to the patch, I just wanted to check if I was missing
something. Probably update the commit message though.
