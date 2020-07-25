Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D78422D6B9
	for <lists+linux-efi@lfdr.de>; Sat, 25 Jul 2020 12:26:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726613AbgGYK0D (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 25 Jul 2020 06:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726572AbgGYK0D (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 25 Jul 2020 06:26:03 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51456C0619D3;
        Sat, 25 Jul 2020 03:26:03 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id z17so8711325edr.9;
        Sat, 25 Jul 2020 03:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=taXyyIg9HQgDUeqgJutr9j6azE5mPr32nbXBE8+jcsA=;
        b=heoJsy/sLGZ8AXN/DQcF3CpRSkdT16DTWOrhYJegxg0KfItLi7dPAnQi4JKgv3kfeq
         GjKcavcYkWvSOrHRkbWGJCqFM3oxjUDNnbiAdSsXr64BjSfS5Q360TdWfXpQh+55BL5q
         KOqY2GT9KZnz0erHQkPe0gLg7ti/LqMtx1+9aSCHO1M/GW2/55eTkVUNwFxs+kDuXq/l
         S4bf2DDIez25tWyumCqygwHbhb/rY7HyaU8sjZvyw/2L/3ZMb6JZNKBzGdYwbdKvpFn9
         s0s0e1HlNuPLHOuetw4HJ+RK4xlIcvOzfO2faKbUjtUCN9LRf2kHA/xrb3hafwQFQvCJ
         9nyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=taXyyIg9HQgDUeqgJutr9j6azE5mPr32nbXBE8+jcsA=;
        b=VIBnUta87dFGjkq40HOXq2rSuNMIHdNHBmRB0alDiykF8cQIabtU97ygFFvdpzuXha
         +5rk+5l18RE9IB77AuHTc+runFCtl7UaIWcPRzxhgCEVFnWV5MH7Auj4vnRTmy8S3Djq
         lad2SSYxvODWuzw4ol+uFi7iOE9Vaxd4QcX3vrB40tDR9XWlnW7iGOaQD+ROORJLK4wc
         82nKFywMGhWGhyfzifZe2fcUhMsvV1TiD1jEYYP0M+LZZgjkVuNOnOA+8HK9JgcgZVXH
         cqr3Nl7P/IqoZPGZZBUbtCe1aOO6jdKYQOLmNvtaOZ9Fibf4B3oQ/v+3l1M+IpbLOORu
         nV0A==
X-Gm-Message-State: AOAM530Ji1V88yBhB5NDMjIXZ8ySwM/oBZojVBb2qSIdV1rZGKdLTqjb
        ExeOJPDKtLFHkv2ncWOOgk9EJtKf
X-Google-Smtp-Source: ABdhPJys+Ykps/4KLTuDE+mkOgM3KbhJT2sHQsbhDYUoOFDEdpRVDg1e1igOYZTLJmXVQ/nbBYtNoA==
X-Received: by 2002:a05:6402:1bc1:: with SMTP id ch1mr4196887edb.142.1595672762017;
        Sat, 25 Jul 2020 03:26:02 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id kt1sm2571657ejb.78.2020.07.25.03.26.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2020 03:26:01 -0700 (PDT)
Date:   Sat, 25 Jul 2020 12:25:59 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [GIT PULL] EFI fixes for v5.8-rc
Message-ID: <20200725102559.GA757519@gmail.com>
References: <20200709132807.32232-1-ardb@kernel.org>
 <CAMj1kXGHDS7PnuPsCnHWGDFdtcaJUuXboZUZQwowzw0LfrQ+pw@mail.gmail.com>
 <CAMj1kXFQt4f0XT6C_4_xAuDALv_jVsc+z0zkSnxh6MU-zHxj2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXFQt4f0XT6C_4_xAuDALv_jVsc+z0zkSnxh6MU-zHxj2g@mail.gmail.com>
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


* Ard Biesheuvel <ardb@kernel.org> wrote:

> Ping again?

Sorry about the delay - sending it to Linus now.

Thanks,

	Ingo
