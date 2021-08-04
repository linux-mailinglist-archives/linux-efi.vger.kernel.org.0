Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 459323E0638
	for <lists+linux-efi@lfdr.de>; Wed,  4 Aug 2021 18:58:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbhHDQ7C (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Aug 2021 12:59:02 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:39639 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239555AbhHDQ7C (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Aug 2021 12:59:02 -0400
Received: by mail-wm1-f52.google.com with SMTP id f9-20020a05600c1549b029025b0f5d8c6cso4373374wmg.4;
        Wed, 04 Aug 2021 09:58:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MQVMEe9oIkhK6OANCKQ+gXkHOtTHQidfijcaEuYUq7U=;
        b=kEQkmmUvAFj455uPURlB8TRsLLO/oQB+Bb3sySe2SRHyS0hwaXdBxfzTCKgVSTLiw5
         Jcac4B74KeyM9EYHvMBHudW7oWBKbAiA7OLxiLLd9ptrkpb7r5cRuESDPsEpYnDohxY3
         jEDXy2td6sj8COcereVyJ7GMew8RTTvI9Zjn1+ezdbvLHHKnui/p8KbstbKBEytQfvOm
         omibbuZ152vBxVwe2MKm0/uRowh5Q48M6RIhK4sGTJhtoc6cwtGKVJ8IrN//ug5tjDaF
         s6bU46ifn/5jQSRuj1kH9S+YUdCqQrX/8la7Px2pJmF73Oh99TlrtB4/fGlEiGAozPjS
         77vg==
X-Gm-Message-State: AOAM533/i6QW+aI/dbhA4z8e3Xa1lEM2e9rHayDQLImViAATr2EtXKsE
        YpexzYQUqU7lo56YHFhKrbk=
X-Google-Smtp-Source: ABdhPJxmsJQvAgB4BRIkvxBIEYz4/5vgT4b7/6NjZ22Tz+pBcKtC/Aisqcj/0STGxrqz3Z28mYPv2A==
X-Received: by 2002:a1c:7402:: with SMTP id p2mr10761098wmc.111.1628096327388;
        Wed, 04 Aug 2021 09:58:47 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id u11sm3190643wrp.26.2021.08.04.09.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 09:58:46 -0700 (PDT)
Date:   Wed, 4 Aug 2021 16:58:44 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Michael Kelley <mikelley@microsoft.com>
Cc:     will@kernel.org, catalin.marinas@arm.com, mark.rutland@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-efi@vger.kernel.org,
        wei.liu@kernel.org, kys@microsoft.com, sthemmin@microsoft.com,
        ardb@kernel.org
Subject: Re: [PATCH v12 0/5] Enable Linux guests on Hyper-V on ARM64
Message-ID: <20210804165844.5ocbkmr64gzxkqdp@liuwe-devbox-debian-v2>
References: <1628092359-61351-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1628092359-61351-1-git-send-email-mikelley@microsoft.com>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Aug 04, 2021 at 08:52:34AM -0700, Michael Kelley wrote:
> 
> Michael Kelley (5):
>   arm64: hyperv: Add Hyper-V hypercall and register access utilities
>   arm64: hyperv: Add panic handler
>   arm64: hyperv: Initialize hypervisor on boot
>   arm64: efi: Export screen_info
>   Drivers: hv: Enable Hyper-V code to be built on ARM64

Applied to hyperv-next. Thanks.

Wei.
