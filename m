Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5240C4FE66A
	for <lists+linux-efi@lfdr.de>; Tue, 12 Apr 2022 18:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357903AbiDLRBn (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 12 Apr 2022 13:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357912AbiDLRBk (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 12 Apr 2022 13:01:40 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C1E11A1E
        for <linux-efi@vger.kernel.org>; Tue, 12 Apr 2022 09:59:22 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id q3so6082919plg.3
        for <linux-efi@vger.kernel.org>; Tue, 12 Apr 2022 09:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sbmtZUHdeimKmpPh1bMlzq0hwzuYX2yluMhfz3rlFSU=;
        b=HWCdYoytGsbjpCL3FGrjxUsGb1RC/BkyeetyCir4NM7dpKTa2umTcHsZYPt8Ts5ZRT
         kkj+OUC2PEuL0b3WmGpSF+16uQqDbUJ5pdvod+3q8BfrGWryansUrTEPMW6R1H6nzHnO
         E+fPvRLMTZAMVhvfA8aSE9c3Z3BjJxvKXteXI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sbmtZUHdeimKmpPh1bMlzq0hwzuYX2yluMhfz3rlFSU=;
        b=jtPcZvUtHQBHm3ahO2h0mh8uFKwRnMLKCiLQ4UC9QExr7RxHc8YmAh/USJuozybRPv
         3Z7T31+3QV1p/hI0nzFCYplwGp8ERSgfK0nSdXMU5E4P6f6hX/55i7NN2FDaGPwDTxbF
         Q5H/cdCeLaBpNA+OxzoKYIiDnlazUNdX4tJunMuKi2I0i7fb9CWAYfT30FGRenq+tsNM
         vAuIyxKHDzKxcNgtm2XyMxRw/GIEPlnVZ84YnBGuvDDplc6TKSlRxN/8MoQsPtBXNS/T
         /9yX/aouPdDd9Ia0kdgZr6W5jOj4xC28SpdNGvMSSe4ysn0j4lmXGb54p+O4OXXUTJw9
         HvyQ==
X-Gm-Message-State: AOAM533e/bsEC0hpBjfcwQVPaMpotUIey/6Iuf22LyDp31opnCXt3d/X
        Z1r2QkpNtG5iBJ3giAu5Qiqvrw==
X-Google-Smtp-Source: ABdhPJw7iU/gNPjilL7EEmCqgRzrhmwbFxKjdbW0t3zk1Pz/3+QxpbfZlGwcC2qUvSClQTbZ5U1T+Q==
X-Received: by 2002:a17:90b:4d01:b0:1cd:46e8:215a with SMTP id mw1-20020a17090b4d0100b001cd46e8215amr618262pjb.73.1649782761864;
        Tue, 12 Apr 2022 09:59:21 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id l4-20020a056a0016c400b004f79504ef9csm39595061pfc.3.2022.04.12.09.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 09:59:21 -0700 (PDT)
Date:   Tue, 12 Apr 2022 09:59:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-efi@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 00/30] arm64: support WXN and entry with MMU enabled
Message-ID: <202204120956.B0ECA2FC@keescook>
References: <20220411094824.4176877-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411094824.4176877-1-ardb@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Apr 11, 2022 at 11:47:54AM +0200, Ard Biesheuvel wrote:
>   - allow WXN to be enabled (with an opt-out) so writable mappings are
>     never executable;

Besides all the rest of this series's awesomeness; this really stands
out to me. I didn't even know this was a feature in aarch64. Nice! I
really like the idea of having this enabled -- anything executing out of
a writable mapping should already be considered a mistake (and tons of
work over the last 2 decades has already gone into making stuff this
doesn't happen in both the kernel and userspace). We could even make a
new LKDTM test for this. (Right now stuff like EXEC_DATA just verifies
that the .data segment doesn't have the X bit... but adding something
like EXEC_WXN where a memory region is made explicitly W+X, and it
_still_ can't be executed would be great.)

Cool!

-Kees

-- 
Kees Cook
