Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451C4553DA3
	for <lists+linux-efi@lfdr.de>; Tue, 21 Jun 2022 23:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356160AbiFUVZP (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 21 Jun 2022 17:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356152AbiFUVY4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 21 Jun 2022 17:24:56 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63AE2F652
        for <linux-efi@vger.kernel.org>; Tue, 21 Jun 2022 14:19:15 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id 68so8797219pgb.10
        for <linux-efi@vger.kernel.org>; Tue, 21 Jun 2022 14:19:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Pw6tOf0NPXvUgCcHpFOHSG/5Ay8ndP0eK1Ju1RYmRfI=;
        b=U2W7vdfgAxIgUEg7l9O4E/VMMQlsLTmezTIDBqG5h6pjmmvxwDMZmZLarqOeb7Wje1
         0xWyG8P2Z+hoG8iHH8gqVe3Wgq8s2we20AfndFGBGC3Y+zBgkbFAQesqeIvgKrLM1mO9
         +iQCUR3ww0HBZXdoYbDfUrrIF7+gQau2zDz3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Pw6tOf0NPXvUgCcHpFOHSG/5Ay8ndP0eK1Ju1RYmRfI=;
        b=KOe3gGINsxlUVZg2X+Z8PaWCPYKCPMtf4T46x3Km/oY6PnQF1RIimOtjXFasUEMOjH
         50zA+7+YLwoL0v84P0Ar+GjE5ayMvMRsVI6t8dxLsQw4/7KVIHrLQopty+EsF73Et6Tn
         89uWbsyCzQI9ggmaaxN2oedrZzOj6zAI3sL+dfn+OmSXToQnJVR752sAc70wINl8wYy5
         yW8CmfudS1eKw6+jg6YrtVuXnyzlNNviUYtts5vwteOPIVlzoZTqCjzaBNqheeV1Zt+G
         TcnAQ2TRUuQF/51ejQOmMnJ5RNFxXeAaU3leWNd/A8ShQugiKU+YfH/N2CKyD1ZjR+5X
         nGpg==
X-Gm-Message-State: AJIora+fOA5+vevfzJTUKUFvLt6PGxwZLWN5IbD19hFVvLeynZpmSnkS
        pvFKIMMVx+qrSvHnx4xdA3IJxaSxSBbZCg==
X-Google-Smtp-Source: AGRyM1tso6knQYUy+Fp/H+yAT+CIm2phikJ+bzB99yq1r6ctawOAnKOwSY68yKxnHNb3wtkcWgir0Q==
X-Received: by 2002:a63:7f0a:0:b0:40c:7993:f177 with SMTP id a10-20020a637f0a000000b0040c7993f177mr16846264pgd.204.1655846355281;
        Tue, 21 Jun 2022 14:19:15 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q11-20020a056a00084b00b0051bc3a2355csm11905905pfk.64.2022.06.21.14.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 14:19:15 -0700 (PDT)
Date:   Tue, 21 Jun 2022 14:19:14 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Peter Jones <pjones@redhat.com>,
        Tony Luck <tony.luck@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH v2 1/9] pstore: Don't expose ECC metadata via pstore file
 system
Message-ID: <202206211402.1D0B5A4D7@keescook>
References: <20220621153623.3786960-1-ardb@kernel.org>
 <20220621153623.3786960-2-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621153623.3786960-2-ardb@kernel.org>
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Tue, Jun 21, 2022 at 05:36:15PM +0200, Ard Biesheuvel wrote:
> If a pstore record has its ecc_notice_size field set to >0, it means the
> record's buffer has that many additional bytes appended to the end that
> carry backend specific metadata, typically used for error correction.
> 
> Given that this is backend specific, and that user space cannot really
> make sense of this metadata anyway, let's not expose it via the pstore
> filesystem.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

"ecc_notice_size" is actually describing the length of the string
generated and appended by persistent_ram_ecc_string().

I've been bothered by this string, though, as it confuses what was
actually stored with additional lines. "Why does every entry end with a
string about ECC?"

I think it's more sensible to show to userspace the record "as stored". We
already prepend some chunking details when a panic write may split the
dump across multiple records, so if anyone needs this IN the userspace
file contents again, it could move there.

I'd rather ECC status be reported at boot, really. Given that nothing I
can find[1] parses the ECC notice string, I think it'd be fine to just
remove it from the string buffer entirely.

-Kees

[1] https://codesearch.debian.net/search?q=Corrected+bytes

-- 
Kees Cook
