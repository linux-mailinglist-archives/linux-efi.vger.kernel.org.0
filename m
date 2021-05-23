Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 193EF38DAB8
	for <lists+linux-efi@lfdr.de>; Sun, 23 May 2021 11:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbhEWJlp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 23 May 2021 05:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbhEWJlo (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 23 May 2021 05:41:44 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FA6C061574
        for <linux-efi@vger.kernel.org>; Sun, 23 May 2021 02:40:17 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id a4so25397029wrr.2
        for <linux-efi@vger.kernel.org>; Sun, 23 May 2021 02:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TkVZowMJRyrwTipOUZIYXQG2BTEYaj0c9HlfmUlYJZQ=;
        b=CK/nDkmGQ0jA3WJyLg8JI21UhXDJlqUm/0pnE4sp+YOKX6DpAUG+FtM06WXucymjTm
         V/6sTTF1BDbuUzY7PnNrt75FjeJeN/HeZKL22q6Ft0gHTJConL2LQ4GuPvDwBmv+22DY
         REU04dWdBlcTAsR1bH6cI5+g6IWXZoI2ZHqWFJJb5Yt4ZwcM55g2j3PftO0Cug7MNhTq
         2VGthlEhHtlH0hfHD4Efg4E9653rSp0/F+kq4F4D4tafHHfCnAQpi95QHLUkzltonPIq
         AlKQITvnuV+mqEBMgyZdGUkrm2jIpdtvab8WzyCHOjo5URqSNyXd/BKm02tSLanseuaI
         F9+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=TkVZowMJRyrwTipOUZIYXQG2BTEYaj0c9HlfmUlYJZQ=;
        b=ZnzZBSupF4yLbSbT4vC93SDxs0iI3Kys8lMSsG4rEkYEhEdKNXMFRyxLKszfuGllwC
         DzkZMW/QWkNbF1cRnOZpicO0mOF/Xsm/mlXIwvTssMSGbMaMyEgIt9z7zddRQ46KaIEM
         UFsaQXVtyeC7L2CMS97ggSEdu6CHBbKx4W4ybs9bb6i13UOHSP8QVyKMDd8tmyFUYYbX
         9TRhy+HTkb2INIo/CtM/3GkUmXBaZaE1Q29fYpsthbjGbbIIibJcq0duciKRRaZflOLo
         AYVQK2+mBXh3HGuHv1Vq+FgV7p7F0IPThDP1Np5gNt81fl/qk3LrsroUNmW72PjoJnIq
         pGVw==
X-Gm-Message-State: AOAM533jZWEGlQIffUsfsxj0YifL88yjCtQFlCx9EtGYxJVuN/23cxdF
        1Hu8Tv5F+B9xln1XtuEMpk8=
X-Google-Smtp-Source: ABdhPJz4eQx/RXtgRpTiOIDmdzQGlKt7RHl7yHQhilNYWB+KX0+269WqvG7NTKXkXSuMg77pgtAxZQ==
X-Received: by 2002:a5d:4c48:: with SMTP id n8mr16786610wrt.422.1621762816351;
        Sun, 23 May 2021 02:40:16 -0700 (PDT)
Received: from gmail.com (178-164-235-213.pool.digikabel.hu. [178.164.235.213])
        by smtp.gmail.com with ESMTPSA id i1sm8064160wrp.51.2021.05.23.02.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 02:40:15 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sun, 23 May 2021 11:40:13 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [GIT PULL] EFI fixes for v5.13-rc
Message-ID: <20210523094013.GA1716068@gmail.com>
References: <20210523090413.70225-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210523090413.70225-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


* Ard Biesheuvel <ardb@kernel.org> wrote:

> The following changes since commit 6efb943b8616ec53a5e444193dccf1af9ad627b5:
> 
>   Linux 5.13-rc1 (2021-05-09 14:17:44 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi.git tags/efi-urgent-for-v5.13-rc2

> EFI fixes for v5.13-rc
> 
> A handful of low urgency EFI fixes accumulated over the past couple of
> months.

>  drivers/firmware/efi/cper.c         | 4 +---
>  drivers/firmware/efi/fdtparams.c    | 3 +++
>  drivers/firmware/efi/libstub/file.c | 2 +-
>  drivers/firmware/efi/memattr.c      | 5 -----
>  4 files changed, 5 insertions(+), 9 deletions(-)

Pulled into tip:efi/urgent, thanks a lot Ard!

	Ingo
