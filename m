Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 041FD321403
	for <lists+linux-efi@lfdr.de>; Mon, 22 Feb 2021 11:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbhBVKVi (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 22 Feb 2021 05:21:38 -0500
Received: from mail-wm1-f47.google.com ([209.85.128.47]:52328 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhBVKVi (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 22 Feb 2021 05:21:38 -0500
Received: by mail-wm1-f47.google.com with SMTP id p3so2835909wmc.2;
        Mon, 22 Feb 2021 02:21:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jqrZ9o2ASN5akD88hAC25nkBz+M3fdiYTEO2MDdzKQE=;
        b=EltAjHHrDhCWuvvepWB334bmL2nekHymABVwrA58UiNIXcEUtlZC1jSXL/TBoc9hwt
         CNyR0epgofOEwA6DycbjKEYODfS963tdNQ6fGZT9lDBjT9KPqlw+rfImcaeBIl9lFlBj
         RzcWypSVwfFNsOGdtX8gmYqWMjtrUA1OkzE67oAbmDLdaVYnn+g8NBZ2dlL4qLEjeWj/
         sdrmyqjNkJX1UMiAvmF4sEbsJUeCSqCP+y1pcnCu/62ySect9K6VpKNYvNVdKYErGLI5
         Z8YK7WX/x5lRG1JbUAJ4YvNDli7ge+L+ZUlrvogOa7v2B12vBOIkbgjHNMH6otZsLw9S
         bS/w==
X-Gm-Message-State: AOAM530qaYHDQYcoPR3OJpXXVlSEYL92zMPdkrqy/+MzTAkHk7hG+RL0
        LUN4XPhLeseZBDSK5sgNkmQ=
X-Google-Smtp-Source: ABdhPJz6cUY0N/jr2N6r9cNHbFyBBPKLgGXIicBYbLYdkyrpqWdneK8zmyzgqA+XPnNl8ArCLJFTWw==
X-Received: by 2002:a05:600c:19c6:: with SMTP id u6mr9172317wmq.65.1613989256338;
        Mon, 22 Feb 2021 02:20:56 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id t16sm10088771wrq.53.2021.02.22.02.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 02:20:55 -0800 (PST)
Date:   Mon, 22 Feb 2021 10:20:54 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        arnd@arndb.de, wei.liu@kernel.org, ardb@kernel.org,
        daniel.lezcano@linaro.org, kys@microsoft.com
Subject: Re: [PATCH v8 1/6] arm64: hyperv: Add Hyper-V hypercall and register
 access utilities
Message-ID: <20210222102054.7ktopdg2jcao7itz@liuwe-devbox-debian-v2>
References: <1613690194-102905-1-git-send-email-mikelley@microsoft.com>
 <1613690194-102905-2-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1613690194-102905-2-git-send-email-mikelley@microsoft.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Feb 18, 2021 at 03:16:29PM -0800, Michael Kelley wrote:
> hyperv-tlfs.h defines Hyper-V interfaces from the Hyper-V Top Level
> Functional Spec (TLFS), and #includes the architecture-independent
> part of hyperv-tlfs.h in include/asm-generic.  The published TLFS
> is distinctly oriented to x86/x64, so the ARM64-specific
> hyperv-tlfs.h includes information for ARM64 that is not yet formally
> published. The TLFS is available here:
> 
>   docs.microsoft.com/en-us/virtualization/hyper-v-on-windows/reference/tlfs
> 
> mshyperv.h defines Linux-specific structures and routines for
> interacting with Hyper-V on ARM64, and #includes the architecture-
> independent part of mshyperv.h in include/asm-generic.
> 
> Use these definitions to provide utility functions to make
> Hyper-V hypercalls and to get and set Hyper-V provided
> registers associated with a virtual processor.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>

Reviewed-by: Wei Liu <wei.liu@kernel.org>
