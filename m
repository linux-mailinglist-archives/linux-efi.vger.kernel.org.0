Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 205FA5B07A1
	for <lists+linux-efi@lfdr.de>; Wed,  7 Sep 2022 16:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiIGOz0 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 7 Sep 2022 10:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbiIGOzI (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 7 Sep 2022 10:55:08 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 541DF10547
        for <linux-efi@vger.kernel.org>; Wed,  7 Sep 2022 07:54:31 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id 14so6130045pfu.9
        for <linux-efi@vger.kernel.org>; Wed, 07 Sep 2022 07:54:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=gyoOqDb14Yjq7NupJNetsKyd+txutejAgX85HjsBNao=;
        b=Q2hSZufrjuE1zLAdBqvEythubyUNFSMjihlGX2sM7LxDfShJnacXgAae+5gLVDYT4Z
         fm6I/+0rsc/+2qkhK0mTR0c2D+geWJCpmN2kb+iSBbCwthYygD/sfsbveSO5n22KlLhj
         sNo4TmSaL/rfqtVafMi9hhk7hi0RwGpJsAohknYEpKry2eLY4VtST6RxWMXxcRjBwsH/
         arC9hxrvbAzZxsoy/WjjRB7uQzoiPAUAOpjAv+DjLdTDIU1Uc1XlTSlFl843De5+gD2V
         snZoQ3TSzwk9xf5K/6c7JXx1FYwuYAq3ZSDo/cZB2ln+ZVCeu/aTpWY1yOR28OKWl8jt
         TbWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=gyoOqDb14Yjq7NupJNetsKyd+txutejAgX85HjsBNao=;
        b=VKFv9SQDAppRMqV+SSGkDV+zJqATL5nbxIoc58FKUSyEbfys95Poh5bo+vxUwAjdFg
         GT2JZVSdhLQZwTXTGztJ7JiEBHHqKD2PoomVhUdGbx6ZZI5uZiVOSMVOIPIyvGZF/zgM
         7zhiSyiFtHJDmHxj/1xtqXpEKIYCsZsMrl31h2GSI8fqhtEiFYKIwTesooLt3/IE365F
         YvZT5arLW1WNK4tGRRdmLTPWRWHqoYCZ6pR/LavlvHp6R2EUnXvhaco3Pp2NbXxW7i3l
         MyeUsvyzMPKlT9oMuBrx0s48xt2caHg65x7BKtipCv4UL0XywcYPO4k83WUPrmCZCmEc
         KY6Q==
X-Gm-Message-State: ACgBeo2Wgvmukz/afXZrCsGeBIrTEtVVIZMlnEjEqTYB0ElwZv5erC/P
        zk7oqLngXsOatOzYZ0F2fg4=
X-Google-Smtp-Source: AA6agR7bRc/vnvpLgCclzRZwFuT2n6xjPbmei4f7ulkkM44t1QlLKpk/wOKWBfejyNa+DgmLvGQFjA==
X-Received: by 2002:a63:5526:0:b0:434:c99c:6fdc with SMTP id j38-20020a635526000000b00434c99c6fdcmr3785144pgb.558.1662562470403;
        Wed, 07 Sep 2022 07:54:30 -0700 (PDT)
Received: from ubuntu ([175.124.254.119])
        by smtp.gmail.com with ESMTPSA id b11-20020a170903228b00b00173cfb184c0sm1582736plh.32.2022.09.07.07.54.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 07:54:29 -0700 (PDT)
Date:   Wed, 7 Sep 2022 07:54:26 -0700
From:   Hyunwoo Kim <imv4bel@gmail.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH] efi/capsule-loader: Fix use-after-free in
 efi_capsule_write
Message-ID: <20220907145426.GA127455@ubuntu>
References: <20220626103248.GA57385@ubuntu>
 <CAMj1kXHo91v8u_RcXfu4r=x5eh-tShBu4gSDZXBRveOC275Fnw@mail.gmail.com>
 <20220907102920.GA88602@ubuntu>
 <CAMj1kXHKBkP8JHUSyzEELovvSzUpfO1j2nA+eUbP-smLWjKPog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHKBkP8JHUSyzEELovvSzUpfO1j2nA+eUbP-smLWjKPog@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Sep 07, 2022 at 04:40:08PM +0200, Ard Biesheuvel wrote:
> As far as your fix is concerned: wouldn't it be better to move the
> freeing of the pages to the release hook? Semantically, flush is not
> the right place for this, AFAICT.

you're right. Freeing the buffer in .flush is wrong.
I also think it's appropriate to move the buffer release part to .release.

But looking at the comments,
/**
 * efi_capsule_flush - called by file close or file flush
 * @file: file pointer
 * @id: not used
 *
 *      If a capsule is being partially uploaded then calling this function
 *      will be treated as upload termination and will free those completed
 *      buffer pages and -ECANCELED will be returned.
 **/

efi_capsule_flush() seems to exist for the purpose of canceling uploads in the middle.

If buffer release is moved to .release, will there be any compatibility issues?
