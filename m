Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B76481EFC36
	for <lists+linux-efi@lfdr.de>; Fri,  5 Jun 2020 17:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgFEPKl (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 Jun 2020 11:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728016AbgFEPKl (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 5 Jun 2020 11:10:41 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316DAC08C5C2;
        Fri,  5 Jun 2020 08:10:40 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id c185so9965868qke.7;
        Fri, 05 Jun 2020 08:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BpK25pF9k97GQANrMAOM4ayOwz19XUu3M8Q+Bj7oXKA=;
        b=rLqdynoxAjps7NUHRkjER++fW3GoX+ZXO37Ce4cYeD8aMWIGjznv+zFN8tNnw9+E97
         LHqyFMlZZznMyQ0ckXIT8QJlZTFfRcVdqtb2nuaBR7peyZeEBsh5kgX8RH7rHrVhVZvR
         ciWqatBHrllGlSqhGITbN0ESt4xt6hzZzvAvK6wK5YQ+PYsTDvM53W5wXPDZySZ51xqu
         vuqBwbBptnb0/OiI4FgOFC4SwVezkDvnZYtMfVjGW+r722a8WqH9qd2aV89e4WHUiDJE
         lO3Oq26noPy+byEgDpaqC7FjPGpTXIeI4f5rSLg8KwsE145lz8B5+hfdK8mqB54v42Cy
         aymg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=BpK25pF9k97GQANrMAOM4ayOwz19XUu3M8Q+Bj7oXKA=;
        b=nni+aC7ulwY6S/SAearAl8fJ5hWxw7xUlX/QpPaLXAdsWbiBqPbm8MWeaRZ1+7ey0T
         Ew15/JUSc1phYKW0XMezsfADXw4QexgAgc/DDHH53w0KiWOaXRQMSw36j2cZMxqenJKo
         hytNwYYmNlSoVvDuM5+nC8JfWF8chj/4Enx3KOInK/dPIZzgmWJit7yJVMJJiIEz01IC
         szLENfALszS7Hh9ddJ/dN5x+IrQ+F3INgoy+N7wmSMvPefCgCEC3j8QklQjjSf7pjgbz
         RxpFWPbFFKQkVL2gzWNq5McGXa9Ai5f72PtPCcXOh6cXkeVq9slTU5Epwbz8kGNlLnOI
         PiNg==
X-Gm-Message-State: AOAM531JtLyCzAbm0kBtpV4fY6niCYB2f39AIlhN9RUNVPvyg42mDyvC
        YpitLYykofj9MfM0dePaKK8=
X-Google-Smtp-Source: ABdhPJzArTY56WDQJ3+DHB1F4wX+Auf5D5Y008s/ZKOntadub4jsgM/l7EUL8gRlU8W+phItoAlJgw==
X-Received: by 2002:a37:ecc:: with SMTP id 195mr9652116qko.469.1591369839422;
        Fri, 05 Jun 2020 08:10:39 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id g9sm4787qtq.66.2020.06.05.08.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 08:10:38 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Fri, 5 Jun 2020 11:10:37 -0400
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Andrey Ignatov <rdna@fb.com>,
        linux-efi <linux-efi@vger.kernel.org>, bpf@vger.kernel.org
Subject: Re: [PATCH 05/24] efi/libstub: Optimize for size instead of speed
Message-ID: <20200605151037.GA1011855@rani.riverdale.lan>
References: <20200518190716.751506-1-nivedita@alum.mit.edu>
 <20200518190716.751506-6-nivedita@alum.mit.edu>
 <20200605003134.GA95743@rdna-mbp.dhcp.thefacebook.com>
 <CAMj1kXGaQGaoiCqQpX4mdN6UQi25=EhqiNZn=sbcgi1YYuJwBA@mail.gmail.com>
 <20200605131419.GA560594@rani.riverdale.lan>
 <20200605133232.GA616374@rani.riverdale.lan>
 <CAMj1kXG936NeN7+Mf42bL-7V5pRVjoNmCKmVT3EcB5EGh2y5fQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMj1kXG936NeN7+Mf42bL-7V5pRVjoNmCKmVT3EcB5EGh2y5fQ@mail.gmail.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jun 05, 2020 at 04:53:59PM +0200, Ard Biesheuvel wrote:
> I guess the logic that decides whether -maccumulate-outgoing-args is
> enabled is somewhat opaque.
> 
> Could we perhaps back out the -Os change for 4.8 and earlier?

I just sent a patch to add the accumulate-outgoing-args option
explicitly. That fixes 4.8.5 and doesn't seem to affect at least
gcc-9.3.0, which presumably already enables it automatically.

Thanks.
