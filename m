Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8614563F637
	for <lists+linux-efi@lfdr.de>; Thu,  1 Dec 2022 18:36:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230056AbiLARgM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 1 Dec 2022 12:36:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiLARgL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 1 Dec 2022 12:36:11 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E038A8099
        for <linux-efi@vger.kernel.org>; Thu,  1 Dec 2022 09:36:05 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id ml11so5891672ejb.6
        for <linux-efi@vger.kernel.org>; Thu, 01 Dec 2022 09:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sUiLP3HVj8YH4yBupV/yT3BIND3qN3UqTt2dNtLnLzw=;
        b=hUjtsP8/e5c4Bddq51PrhsmWWxj5MdmVAyoi3rGLKdr8xD9RNL95k+pAlKATPWC0q8
         73PpZBRfoaEm/0zUsHuY/0OIzOkEa5l/TfHg4NN5FfYyH+TjqXdUUjtdtgeTX0G47MSa
         L5qOay1X5rKz+YiDI1pzJLKGiEG5wIrDPLQ1lIGvdZEXUi4HeGTvMYzNNeZlSmu3Q5X3
         S98cbMY1iIb4fc4ecz9F0I4yh9FnhI7zzHL8IiRjiHdM8YH+upx9zdZ5jd2g8LFiSS6w
         ZyLHOrXMC42eDWjy8/O/LaNRI21QRI/MvCK1FT5U19fLe7OKmSAHWNxBIbs619x5xanz
         j9iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sUiLP3HVj8YH4yBupV/yT3BIND3qN3UqTt2dNtLnLzw=;
        b=iDhOtTdSsSY/hwxoXtpW8+cn6bzUrHXPKolX4cnuUJDy69rPexOnsMJW3SWgbqwRzn
         zZ4jquZyZZUJJOIHJzgcSvAfq89fC6eHPOzWOqkCQzndBThSX9dtXL4PN7Nzu8QKFfLD
         h4h7nrXEIWk99DlibkV+KFh8YRE87dqUDz1pHdefZUYt8FvQ3JKMAkPCrZl6F4dzQX54
         m1/K6dmYcAj/fSfkw6UEN4DHljdmGzk2/vIlc4y9rGsuAHFzzORvhe5ed+vSRQ9fm+Y6
         HYvBk1svnBbuLC+ml32ygHu3Dk2KOyJx7ZlSp7OuNxan9/61AE8sxNOdvsmvsonaP6b+
         lO1g==
X-Gm-Message-State: ANoB5pn10EbwnyfIikJivI7pHA/awmf9WXScacMw3TOPtYrbjZyYcvk9
        EBIKbFC7VxJDq37u+taCMuE55g==
X-Google-Smtp-Source: AA0mqf6+VGfYLPuKuiOL3rmwlDbKY6bwok1PYqxvj6c+XUM9aWCNSdeL/ujG+mkQ5M5LKkbI81Wg/w==
X-Received: by 2002:a17:906:2692:b0:789:d492:89f5 with SMTP id t18-20020a170906269200b00789d49289f5mr59194395ejc.103.1669916164173;
        Thu, 01 Dec 2022 09:36:04 -0800 (PST)
Received: from localhost (cst2-173-16.cust.vodafone.cz. [31.30.173.16])
        by smtp.gmail.com with ESMTPSA id l18-20020a1709060cd200b007adf2e4c6f7sm1980516ejh.195.2022.12.01.09.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 09:36:03 -0800 (PST)
Date:   Thu, 1 Dec 2022 18:36:02 +0100
From:   Andrew Jones <ajones@ventanamicro.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-riscv@lists.infradead.org, palmer@dabbelt.com,
        christoph.muellner@vrull.eu, prabhakar.csengg@gmail.com,
        conor@kernel.org, philipp.tomsich@vrull.eu,
        emil.renner.berthing@canonical.com, ardb@kernel.org,
        linux-efi@vger.kernel.org,
        Heiko Stuebner <heiko.stuebner@vrull.eu>,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v3 03/14] RISC-V: detach funct-values from their offset
Message-ID: <20221201173602.6slgaxk2qdkfatxm@kamzik>
References: <20221130225614.1594256-1-heiko@sntech.de>
 <20221130225614.1594256-4-heiko@sntech.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221130225614.1594256-4-heiko@sntech.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Nov 30, 2022 at 11:56:03PM +0100, Heiko Stuebner wrote:
> From: Heiko Stuebner <heiko.stuebner@vrull.eu>
> 
> Rather than defining funct3, funct4, etc values pre-shifted to their
> target-position in an instruction, define the values themselves and
> only shift them where needed.
> 
> This allows using these funct-values in other places as well, for example
> when decoding functions.
> 
> At the same time also reduces the use of magic numbers, one would need
> a spec manual to understand.
> 
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Heiko Stuebner <heiko.stuebner@vrull.eu>
> ---
>  arch/riscv/include/asm/parse_asm.h | 100 +++++++++++++++++------------
>  1 file changed, 59 insertions(+), 41 deletions(-)
>

Reviewed-by: Andrew Jones <ajones@ventanamicro.com>
