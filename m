Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C18BA7ADDA7
	for <lists+linux-efi@lfdr.de>; Mon, 25 Sep 2023 19:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbjIYRNc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 25 Sep 2023 13:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbjIYRNb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 25 Sep 2023 13:13:31 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1119312A
        for <linux-efi@vger.kernel.org>; Mon, 25 Sep 2023 10:13:22 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-2774f6943b1so1921828a91.0
        for <linux-efi@vger.kernel.org>; Mon, 25 Sep 2023 10:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695662001; x=1696266801; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C8AVXr6vllU577ND8JQi6s5Wb2XnBxy1FQk2gXYImts=;
        b=nwdwXGckYPlPX21pEof3xnvcqZtcLo+KJ3+jVK0axkL3B9r8vRWYdHvuPmYQG+0SMW
         0kplhw0TQhtU0Iwi8LNa4wT1D+uBm3rl8SZyA+8Yw+2aNjTVr3NIha6HuMFqSvToYIPN
         2KvBec9sl1KfxAXU/PbYcm2nl3P/IgqmPDnkQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695662001; x=1696266801;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C8AVXr6vllU577ND8JQi6s5Wb2XnBxy1FQk2gXYImts=;
        b=tsLcC9vq0Iz+oWtNknnwo2QIXEgxhRwgxXlzzIY4EXaBSGTmq0RA6Q2vZNWJj3wU0O
         NweCX3I2Omu3wo2a3a3MgYiK31MzvjbfTqYp3enXlJVp3emRa62wGUydql9XESVz68fa
         0oH/7w1okVv58x9H4fICQZqBn5LWJXghmqsxCHhMb+H1GAbkPGvpooFiE0x4n4Zx/ofp
         yHZbo+VvxMVD+yaIWOc3SPrBen80c5XupULTrLPlDUkn7iLJ2HJy0IWgM3dkqLJz8QJ7
         p3QFAcXXV8LEGewVNkyLuOfoOyO2TN4H+N2xUbgeYioSy7jTYx/OkISOqCK2k7McqFDz
         BD2w==
X-Gm-Message-State: AOJu0Yy4VcuT42SxTjT0f3J8EEzVLLsoQRArTAgd50Y34tOJtZ6LILE0
        cbsL0tJNa6XZODH5+dUnpWawIw==
X-Google-Smtp-Source: AGHT+IHWl3AN866Dif5RDGSG6cKkeY0zzlRZ9iz5O7jZ3LOhJATZBUXvLNzYu+Ccp3gZwtb6gOE9uw==
X-Received: by 2002:a17:90a:4e4e:b0:268:f987:305f with SMTP id t14-20020a17090a4e4e00b00268f987305fmr6859749pjl.46.1695662001491;
        Mon, 25 Sep 2023 10:13:21 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 20-20020a17090a199400b00268b439a0cbsm9146846pji.23.2023.09.25.10.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 10:13:21 -0700 (PDT)
Date:   Mon, 25 Sep 2023 10:13:20 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     tony.luck@intel.com, gpiccoli@igalia.com, rafael@kernel.org,
        lenb@kernel.org, james.morse@arm.com, bp@alien8.de,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, ardb@kernel.org,
        robert.moore@intel.com, linux-hardening@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-efi@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org,
        baolin.wang@linux.alibaba.com
Subject: Re: [RFC PATCH v2 1/9] pstore: move pstore creator id, section type
 and record struct to common header
Message-ID: <202309251012.AD87704BB@keescook>
References: <20230925074426.97856-1-xueshuai@linux.alibaba.com>
 <20230925074426.97856-2-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925074426.97856-2-xueshuai@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Sep 25, 2023 at 03:44:18PM +0800, Shuai Xue wrote:
> Move pstore creator id, section type and record struct to the common
> header, so that it can be use by MCE and GHES driver.

I would prefer this was not in the pstore header -- this is a backend
detail that should stay in backend headers.

-Kees

-- 
Kees Cook
