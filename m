Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F30C63FC3A
	for <lists+linux-efi@lfdr.de>; Fri,  2 Dec 2022 00:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbiLAXpa (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 1 Dec 2022 18:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232021AbiLAXpW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 1 Dec 2022 18:45:22 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC76FC4637
        for <linux-efi@vger.kernel.org>; Thu,  1 Dec 2022 15:45:18 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id x66so3382175pfx.3
        for <linux-efi@vger.kernel.org>; Thu, 01 Dec 2022 15:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iPx3c/iMRNIJSXpniMm7lqyszu5o4JQfscX6wxkm4eg=;
        b=Q3LVH8EsZYQXyyjgGe5HM05z7cuqJYtEkP2Dz2/YBDb+zsK/tcnsYjNzSqSHndf2t9
         eUN3oBDPC3QYF+DEz6xKl+PSTqtk/5OCqvtGVNLKeKyrDGFwPp+DxDfKrvSXruXXRGrH
         Mz4gzPRMbqDiB42vDbMvQNeiBUNX3lppZyKQQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iPx3c/iMRNIJSXpniMm7lqyszu5o4JQfscX6wxkm4eg=;
        b=7Gu/8GsgoW5yIPruDqwvEK7PxqTv2hMW9rYPPcRkidE+qqziNkUfD5fn2xvAYP6KS6
         fBI3ZTiVMv8FZNRDsFHXbL2ViQz/YM9UiFJ16B5DgRN5lulF8WFYmmTBcVCUy8KIIySS
         CyEwezVSg0bCk5cjEy0AaFogFvLz8kk20efXpBZ5VCC+09mtDY+83cmCQtvO0pFx1OzY
         n+jUM/WZYZg4X8KhvqJW/oI/8LiNMy0GpTdiAF5okOpB5MMW4wN6J+3silMKFT8N/6uL
         XGiJgSiEWadVrSS2rGQyS5chJaNXqpg2U2Enmi6KPW/tGuII898Lz0bkH+Om/pBbfMdl
         Nlfg==
X-Gm-Message-State: ANoB5pll/2IdZ+w1n4mfCdvpwaft3H6Jq7dtkGbV80uuTa7oNAukKi6w
        h4guPW5fPaarylcVL/qZwVLIsw==
X-Google-Smtp-Source: AA0mqf502W/pl5x3LK7VdSO/A59w+QmG3SwPUwus+IPiG3VZgsbQM+wGdvmsreHo2YrHHGnVzziHHA==
X-Received: by 2002:a63:5d0d:0:b0:43c:6413:322c with SMTP id r13-20020a635d0d000000b0043c6413322cmr48437390pgb.472.1669938318218;
        Thu, 01 Dec 2022 15:45:18 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id w64-20020a17090a6bc600b00219025945dcsm5429454pjj.19.2022.12.01.15.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 15:45:17 -0800 (PST)
Date:   Thu, 1 Dec 2022 15:45:16 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        Sami Tolvanen <samitolvanen@google.com>
Subject: Re: [PATCH] arm64: efi: Make runtime service wrapper more robust
Message-ID: <202212011544.2AA7C8A5@keescook>
References: <20221128094939.801232-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221128094939.801232-1-ardb@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Nov 28, 2022 at 10:49:39AM +0100, Ard Biesheuvel wrote:
> Prevent abuse of the runtime service wrapper code by avoiding restoring
> the shadow call stack pointer from the ordinary stack, or the stack
> pointer itself from a GPR. Also, given that the exception recovery
> routine is never called in an ordinary way, it doesn't need BTI landing
> pads so it can be SYM_CODE rather than SYM_FUNC.

Does this mean x18 is now being spilled to the stack? (Do we already
spill it in other places?)

-- 
Kees Cook
