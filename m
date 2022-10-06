Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997F75F719A
	for <lists+linux-efi@lfdr.de>; Fri,  7 Oct 2022 01:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbiJFXQx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 6 Oct 2022 19:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232289AbiJFXQu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 6 Oct 2022 19:16:50 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A504CD5DE
        for <linux-efi@vger.kernel.org>; Thu,  6 Oct 2022 16:16:49 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id o9-20020a17090a0a0900b0020ad4e758b3so3166409pjo.4
        for <linux-efi@vger.kernel.org>; Thu, 06 Oct 2022 16:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=JGLxKCv1HjPO+SVC7x6JAIJWQMGRk3XmZwZRy/JbCo0=;
        b=ndN9TehJV2QHvErqjrgZlY49UhMoTa/Oo9BqjYn7hVxxhJqo7zp1LFyQJVU1a+ASyy
         BI/aRMBEvQLD+bZ3jwtvI8NnMpnjA3bfyoYo8F+yiUfEnDnqFC5cYvTt6A8rBqhX5ZD+
         8u5Cqb6pfntMrXvEvNz+UGx+ACxsNr294hJVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=JGLxKCv1HjPO+SVC7x6JAIJWQMGRk3XmZwZRy/JbCo0=;
        b=OSWaAsnvHRnh5qphy4AX/LABp5NdZ2Qw/sDRHcMND84AOv8YMgsQtLyJMBWG2AahaD
         q9mTaBzMNtxQ+lh4UaxJtzK0idZsQozP519LAU1V9JqVky+nFcy8vJG0okGTc9FRZKhj
         l+/+JOKaZEow/wxUDi7AAL+6UDtihuaJxVUq+qX+Z/zNzWqtdHA1i7qM76l364Tt88lu
         yu3zf1Si68j1VJrVGphl4vSKoO944w044NgQs83kMTyLujQKl6M7GLe8O89WHrqTsdO8
         XAlOElNcg9KjcauUDOIq2XQmZvIQ7ucna3Pu0WSoYoxZtA57YXj+f6903wzS5NXm2qkN
         E5sQ==
X-Gm-Message-State: ACrzQf2nTpkU44rbDN72TriXJId5NodFV7ggA6154tXC53anp716cRLw
        0NpYQGe3XEZZSF4cgOauDnKUvA==
X-Google-Smtp-Source: AMsMyM4+RmM9c/OEDHEg1vJGR8qkh8RLKffK7BAjP89CeyWo989iUja+7jRInSWma3jAkyvmMBaskg==
X-Received: by 2002:a17:902:b705:b0:17a:dd:4c3e with SMTP id d5-20020a170902b70500b0017a00dd4c3emr1785011pls.14.1665098208971;
        Thu, 06 Oct 2022 16:16:48 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i15-20020a17090332cf00b0017f6c9622b9sm148894plr.183.2022.10.06.16.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Oct 2022 16:16:48 -0700 (PDT)
Date:   Thu, 6 Oct 2022 16:16:47 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        kernel-dev@igalia.com, kernel@gpiccoli.net, anton@enomsg.org,
        ccross@android.com, tony.luck@intel.com, linux-efi@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 7/8] efi: pstore: Follow convention for the efi-pstore
 backend name
Message-ID: <202210061616.40497D6C@keescook>
References: <20221006224212.569555-1-gpiccoli@igalia.com>
 <20221006224212.569555-8-gpiccoli@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221006224212.569555-8-gpiccoli@igalia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Oct 06, 2022 at 07:42:11PM -0300, Guilherme G. Piccoli wrote:
> For some reason, the efi-pstore backend name (exposed through the
> pstore infrastructure) is hardcoded as "efi", whereas all the other
> backends follow a kind of convention in using the module name.
> 
> Let's do it here as well, to make user's life easier (they might
> use this info for unloading the module backend, for example).
> 
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

Looks fine to me. Ard, if you don't object, I can carry this in the
pstore tree.

-- 
Kees Cook
