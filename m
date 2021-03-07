Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7EE7330035
	for <lists+linux-efi@lfdr.de>; Sun,  7 Mar 2021 12:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbhCGLCh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 7 Mar 2021 06:02:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231883AbhCGLCg (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 7 Mar 2021 06:02:36 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE478C06174A
        for <linux-efi@vger.kernel.org>; Sun,  7 Mar 2021 03:02:35 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id 16so3809743pfn.5
        for <linux-efi@vger.kernel.org>; Sun, 07 Mar 2021 03:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fGQzsTwieGJ+UsLlk4kxZajLdbBFP7Z9G/rD+ogP0AI=;
        b=jJuzCq5vFClSpvp5DuROAFTlcSJqNeusrx5aG+tDb8KJ6vMNJZNHABUSwZngPxsIiC
         +37MlDiEyx3159XFurcZxJFG6Qcb4zjjANOBz7sxIyiuxwPl6LbmyaGnKkndsLW3SpkQ
         kcxn/oc1AewVX/LdHFHdPedmBLaBuNzkGFTNixksBP0AX70Vww5rEhwEulfbENv8VzIj
         xW6nD+ToTtUgaUaJbH+fjgQK9iVwNj76upQzIteRGfRSbAPIQ4DeX8eBKLIpi5HOfj7X
         jDoRs+viipI3a5yzllZebmbXlKRKdMQfBay1hHYG9zBeFyUEasmqUsECXoKgdrwkGhYq
         G4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fGQzsTwieGJ+UsLlk4kxZajLdbBFP7Z9G/rD+ogP0AI=;
        b=kqLP3WijEdE+HkpwkP+JIoRYLGFf5DIsfRo7qA4jLXGgzfnutpjTEq7DXbEtOeA2TV
         l1azU/kLOBVfSBVAUHWbqwRmOfhyDArxJ+VnTaKYcD11C0XzfHY9zNaWwbOt0e8O3xao
         Wp3IdoDYhIs8LHKPqvlz4Y3RraJDWiNVM3TpeIE1NdUDvxty/tXA2mXSok75SZ5DF811
         MZrtMtWpzmC2hTYFk82n1Fm8BPfKzfRdujdOVSLW8UMqcV60s6em5bOssBtKstjW3vzM
         jJz92wsgTgygsst5nAj/d3BFxs0UKFLrZiHgl0vSPvcjiyowpKG1hZxOEIe4WuKaD2Qu
         EjMQ==
X-Gm-Message-State: AOAM5308W0aogAbPCENFMLKzSOBEAjegnjOpSTZ3k+QQj+Xqbs7V1Ayf
        Ld+Xyp3y2lXSRPF176G/NXQ3og==
X-Google-Smtp-Source: ABdhPJzw69vmH0tOiY3QhD5ZExxRFZEu2NUGV17EJAY/jeV7bnDxWXkjlFRl3V+MwwUh6aayB7lkSA==
X-Received: by 2002:a63:1d5b:: with SMTP id d27mr11870099pgm.169.1615114955342;
        Sun, 07 Mar 2021 03:02:35 -0800 (PST)
Received: from dragon (80.251.214.228.16clouds.com. [80.251.214.228])
        by smtp.gmail.com with ESMTPSA id x4sm212115pfn.134.2021.03.07.03.02.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Mar 2021 03:02:34 -0800 (PST)
Date:   Sun, 7 Mar 2021 19:02:29 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, Jeffrey Hugo <jhugo@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Leif Lindholm <leif@nuviainc.com>,
        linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] efi: stub: override RT_PROP table supported mask based
 on EFI variable
Message-ID: <20210307110228.GP17424@dragon>
References: <20210306113519.294287-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210306113519.294287-1-ardb@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, Mar 06, 2021 at 12:35:19PM +0100, Ard Biesheuvel wrote:
> Allow EFI systems to override the set of supported runtime services
> declared via the RT_PROP table, by checking for the existence of a
> 'OverrideSupported' EFI variable of the appropriate size under the
> RT_PROP table GUID, and if it does, combine the supported mask using
> logical AND. (This means the override can only remove support, not
> add it back).
> 
> Cc: Jeffrey Hugo <jhugo@codeaurora.org>,
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Rob Clark <robdclark@gmail.com>
> Cc: Leif Lindholm <leif@nuviainc.com>
> Cc: linux-arm-msm@vger.kernel.org
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

Awesome, Ard!  On both Lenovo Yoga C630 and Flex 5G latops:

Tested-by: Shawn Guo <shawn.guo@linaro.org>

With 'OverrideSupported' EFI variable added from UEFI Shell, we can drop
'efi=novamap' kernel cmdline and get around the broken poweroff runtime
services nicely.  Thanks!

Shawn
