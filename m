Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0CB34B9DAB
	for <lists+linux-efi@lfdr.de>; Thu, 17 Feb 2022 11:55:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239004AbiBQKzO (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 17 Feb 2022 05:55:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbiBQKzO (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 17 Feb 2022 05:55:14 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E02A2944C1
        for <linux-efi@vger.kernel.org>; Thu, 17 Feb 2022 02:55:00 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id om7so5181760pjb.5
        for <linux-efi@vger.kernel.org>; Thu, 17 Feb 2022 02:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Fnwcqhh2WiJm+E2KIQNPJuGkoPvnjSJ+UBtZWNW9CHc=;
        b=Cesm3oQNnw/my6XDNUnTjVHK/VKYNXbSaAMCwD9OODC79yTE0JATBJuCuLdz2ZuMEX
         vYjXEpoSoohhTuNzqszr9E3C2UdO5E3MT+sVktzQW6Rck54mkh3ZRqwUReS4qIbqPucV
         GCySJJm6Rq90E0fBDJqc+OIAeX8yjgFzZnGhspsFZ2h1HAh+HOBqVGEPz4IWYWki4Sx3
         /820XTBrj11tk1q6TS/E6QJYevrUBd04UquRaaU3N7NfVlX3GpbATqCCg4IHZDp1ECGR
         HuVq+OIiaX2U4FJe7zashtP0fxAiYg93Y+jm12FQ7a0pXTeFegEAIu5vKBf4LbZxtYq3
         ALxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Fnwcqhh2WiJm+E2KIQNPJuGkoPvnjSJ+UBtZWNW9CHc=;
        b=wLBVSghJc3M331yNZprnhFXIEH6MJYcyeeDTdWhJtT5BCPeesosrxmLja50f/q+S0g
         Pdgzl1EAw8HM9G7ewOnPBzS2v5Ork2T+tikzsuoRDEJPa7HO+ijeIs5PqOWRLUnNEuzK
         Z6stzdjnH2V7POlKBv57rW0YFA5zNrWv0FCQbX7b4Q2gGaAcf8W3sM/KhpNhkyJyNH88
         TimUTF7v1oytcvJ7JYMr6hG6TwjtRBnlm0vP1osAcH66fie0ZLBSgab7+P9JinYpPcGy
         XvbVLNIcjHiB9LbQck8/afk/re+fykS9mlOWdvY1MdJRcX6dlfAn3fTpGGLhk2X2TD3K
         HbSg==
X-Gm-Message-State: AOAM532AxN21H0uVd6d7QawpJ6qC8EZk79XL1l9OsJjwgdwoZu//fKxm
        iys07dS+kP3Z0G7R5PnxWjA27QItI2l32g==
X-Google-Smtp-Source: ABdhPJyqYiv4ku/c/Cu0cd/Ah85FRKAie0Vzan4s13zN7vGnIECKh344pF3tvaNTHF8UA9ka3rVvIA==
X-Received: by 2002:a17:90b:4c4a:b0:1b7:9c92:1cbe with SMTP id np10-20020a17090b4c4a00b001b79c921cbemr6604071pjb.229.1645095299834;
        Thu, 17 Feb 2022 02:54:59 -0800 (PST)
Received: from sunil-ThinkPad-T490 ([49.206.7.17])
        by smtp.gmail.com with ESMTPSA id l8sm50606835pfc.187.2022.02.17.02.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 02:54:59 -0800 (PST)
Date:   Thu, 17 Feb 2022 16:24:50 +0530
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>, linux-efi@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>, stable@vger.kernel.org
Subject: Re: [PATCH] riscv/efi_stub: Fix get_boot_hartid_from_fdt() return
 value
Message-ID: <20220217105450.GA20183@sunil-ThinkPad-T490>
References: <20220128045004.4843-1-sunilvl@ventanamicro.com>
 <877d9xx14f.fsf@igel.home>
 <9cd9f149-d2ea-eb55-b774-8d817b9b6cc9@gmx.de>
 <87tud1vjn4.fsf@igel.home>
 <49d3aeab-1fe6-8d17-bc83-78f3555109c7@gmx.de>
 <87pmnpvh66.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pmnpvh66.fsf@igel.home>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Feb 14, 2022 at 12:09:05PM +0100, Andreas Schwab wrote:
> On Feb 14 2022, Heinrich Schuchardt wrote:
> 
> > On 2/14/22 11:15, Andreas Schwab wrote:
> >> On Feb 14 2022, Heinrich Schuchardt wrote:
> >>
> >>> set_boot_hartid() implies that the caller can change the boot hart ID.
> >>> As this is not a case this name obviously would be a misnomer.
> >>
> >> initialize_boot_hartid would fit better.
> >>
> >
> > Another misnomer.
> 
> But the best fit so far.

Can we use the name init_boot_hartid_from_fdt()? While I understand
Heinrich's point, I think since we have "_from_fdt", this may be fine.

I didn't rename the function since it was not recommended to do multiple
things in a "Fix" patch. If we can consider this as not very serious
issue which needs a "Fix" patch, then I can combine this patch with the
RISCV_EFI_BOOT_PROTOCOL patch series. 

Hi Ard, let me know your suggestion on how to proceed with this.

Thanks
Sunil
> 
> -- 
> Andreas Schwab, schwab@linux-m68k.org
> GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
> "And now for something completely different."
