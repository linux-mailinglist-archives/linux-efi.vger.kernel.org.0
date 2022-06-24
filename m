Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48BA155A021
	for <lists+linux-efi@lfdr.de>; Fri, 24 Jun 2022 20:07:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiFXRa3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 24 Jun 2022 13:30:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiFXRa0 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 24 Jun 2022 13:30:26 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3411A3E5C3
        for <linux-efi@vger.kernel.org>; Fri, 24 Jun 2022 10:30:25 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id o18so2695289plg.2
        for <linux-efi@vger.kernel.org>; Fri, 24 Jun 2022 10:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v2GOxsdoVsaZXbVgLmusuJ8AUNrNNpTNLGvKGWBrh8o=;
        b=OJsudXwOMYv/+uIFVCAy9ZHd+hLkuAC8DSDK1yeMkLccT+t9CIPMdgpMgi3dNglErN
         vjrXLXCxn0Isb7JwLx6gtRLjX0ue9nCcYi2HxBQfyTL7gzwOzMUurRZnVPzjGGXytiUX
         8QKEfAbE62kS6eIKHPOs4cbXWEQzFVqou8DJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v2GOxsdoVsaZXbVgLmusuJ8AUNrNNpTNLGvKGWBrh8o=;
        b=5NANLAAM3qJ+lD+B1xC86y7NwTlk59JP1FtzgHQBS6amWRN/ZIa+XORK1Q0yVtKvzv
         WTwzUdVepE+JCBQvOkdjAOKdCzXGUrI4ku3RrBHCHwo6oLnlvKgqSGqHYNmxWUzJzZTg
         APu/AsZ/FEcKv+bHu+Od4d1WkBy3QpI1gaCaHw/WmmBwSNJMMH7n2hUYns52C58Tc46C
         /K30/eLfapdzB1lZwW/dqINJC7dTJjQ0WznO/YC3hzNeinMdGxzkqN9BmwKOI4KtIZGZ
         ltAqrNnJaLOgjRFns1Cgi4fQVS7G9Frvk/4IdF/NPZM6zY7ooV2pKDL+zyjOkiKlcMTa
         6pIw==
X-Gm-Message-State: AJIora+xaP3kRUQVRr13VHeZhPofy7/WWIkPuWglhzvGPoWoXBBlgcxw
        Dzz+lFWwN3pPsGIQ0ighxtihRQ==
X-Google-Smtp-Source: AGRyM1uZTK3A1CVfTWihEZf+BbMTle53u4bICa5k01rPPWkPoK245E6WQSY+2isNcfDoVNY/wnEPtA==
X-Received: by 2002:a17:90b:1b0e:b0:1ec:e2f6:349e with SMTP id nu14-20020a17090b1b0e00b001ece2f6349emr5218674pjb.14.1656091824621;
        Fri, 24 Jun 2022 10:30:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m13-20020a170902e40d00b00167838b82e0sm2059425ple.205.2022.06.24.10.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 10:30:24 -0700 (PDT)
Date:   Fri, 24 Jun 2022 10:30:23 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>, Jeremy Kerr <jk@ozlabs.org>,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v3 1/9] pstore: Add priv field to pstore_record for
 backend specific use
Message-ID: <202206241029.9C0891C5B6@keescook>
References: <20220624084925.724516-1-ardb@kernel.org>
 <20220624084925.724516-2-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220624084925.724516-2-ardb@kernel.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Jun 24, 2022 at 10:49:17AM +0200, Ard Biesheuvel wrote:
> The EFI pstore backend will need to store per-record variable name data
> when we switch away from the efivars layer. Add a priv field to struct
> pstore_record, and document it as holding a backend specific pointer
> that is assumed to be a kmalloc()d buffer, and will be kfree()d when the
> entire record is freed.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

I'm a fan! This is useful, and I'll likely try to use it for some of the
RAM-specific things too. :)

Acked-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
