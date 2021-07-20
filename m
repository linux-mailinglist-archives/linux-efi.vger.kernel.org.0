Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6D343CF8DF
	for <lists+linux-efi@lfdr.de>; Tue, 20 Jul 2021 13:34:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbhGTKxU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 20 Jul 2021 06:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbhGTKxS (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 20 Jul 2021 06:53:18 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D0BC061574
        for <linux-efi@vger.kernel.org>; Tue, 20 Jul 2021 04:33:54 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id gb6so33801033ejc.5
        for <linux-efi@vger.kernel.org>; Tue, 20 Jul 2021 04:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=15guqC/HBG7Dic1OlUp77ZbcX1TBQzpIElAR/75+W6w=;
        b=pKKjhY3w7bfWjwki0FxgBeB1Ia/PnPUqn9FEkXEyySCzX/ebeRuPMVEdu4WGw7IgKD
         E4Yljj12HDbA4rKavWFPHV8eSHOzTDE/ck81rNmDELlIgFNn2N4hM12Q7VLKbp/cvq/8
         54smI0sVHzhGOj1KFaANCf8twaevhidVmgk+mNnc0tP6iPru98ne3eQzq+yv47EkVeDt
         ERH4TIEz4MIdYzC48R5pL3JFrSH2ZTyBVPhCl+F/ttkv99v6smiKTpIoCJET9wX4Atv2
         BCwnjzJxmlJ8R3w3ASca0JHQbolbJ+4mYiO0TPH0RDoiGhoDvYJ2mW2UUYFlY9MtiyMy
         KImg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=15guqC/HBG7Dic1OlUp77ZbcX1TBQzpIElAR/75+W6w=;
        b=FCrcrgsZwmdJyFJNppOCtwYR1z1PCFAC/WcikM7HhqqsSTFQbvTmXMErTQUuUtCv/A
         gRzfY3WYZIs6V1z+kKfTM58pZlc9XJOoCaq5m88I5TTieZt8ZTWjLLMBfc3KYKVuOiGO
         we8ikqkk7Brkx4WVauHS7vISzddyXRRplEaThVo6bf33vBOo69xNnsif5Y/7RkPOL9Ib
         C+9itPPkU/Ynd+lyzsSKxFXS5WkUO1b+mDHWES2L5LmAYqmN8fRhQTXz8KTmEiw4Th8T
         VWsVRfbkiq5k0hknVjL7K3j+tAK2/BAtA8PPyIdSMGxYLBGOLqysFivA8hY9nz6JHtS1
         1N/A==
X-Gm-Message-State: AOAM533/S6N98DMW+IJbumskunGz8Zgbgj9ykHDq+9pawlaUpVWT/mOS
        JiNjpDe7eDE+PZiCPUzX/PU=
X-Google-Smtp-Source: ABdhPJyYhX+S/FVZFTRUPH2zaZTRMlbzPAKqZ2waaCBPTRpUB62bfNvTLMHq1QhG87sdamcd3X2Giw==
X-Received: by 2002:a17:906:dc0f:: with SMTP id yy15mr31443923ejb.255.1626780833461;
        Tue, 20 Jul 2021 04:33:53 -0700 (PDT)
Received: from gmail.com (62-165-196-62.pool.digikabel.hu. [62.165.196.62])
        by smtp.gmail.com with ESMTPSA id l1sm7111407ejk.17.2021.07.20.04.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 04:33:52 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 20 Jul 2021 13:33:50 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [GIT PULL] EFI fixes for v5.14-rc2
Message-ID: <YPa0nvuYa5apyQTV@gmail.com>
References: <20210720073311.55452-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210720073311.55452-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


* Ard Biesheuvel <ardb@kernel.org> wrote:

> The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:
> 
>   Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent-for-v5.14-rc2
> 
> for you to fetch changes up to 47e1e233e9d822dfda068383fb9a616451bda703:
> 
>   efi/mokvar: Reserve the table only if it is in boot services data (2021-07-20 09:28:09 +0200)
> 
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Borislav Petkov <bp@alien8.de>
> 
> ----------------------------------------------------------------
> EFI fixes for v5.14-rc2:
> 
> - Ensure that memblock reservations and IO reserved resources remain in
> sync when using the EFI memreserve feature.
> - Don't complain about invalid TPM final event log table if it is
> missing altogether.
> - Comment header fix for the stub.
> - Avoid a spurious warning when attempting to reserve firmware memory
> that is already reserved in the first place.

>  4 files changed, 23 insertions(+), 7 deletions(-)

Pulled into tip:efi/urgent, thanks a lot Ard!

	Ingo
