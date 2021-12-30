Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46D3C481D1B
	for <lists+linux-efi@lfdr.de>; Thu, 30 Dec 2021 15:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240169AbhL3Oel (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 30 Dec 2021 09:34:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240014AbhL3Oel (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 30 Dec 2021 09:34:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F77C061574;
        Thu, 30 Dec 2021 06:34:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85C48B81A71;
        Thu, 30 Dec 2021 14:34:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03F14C36AEB;
        Thu, 30 Dec 2021 14:34:37 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="YH5nDWc7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1640874876;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lHuXjtnGIwA8Zzr3bT7RPQh03xIe4TvMRJ0gk9Qtcas=;
        b=YH5nDWc7fNd5rTZ2A/2bNJrQ2boCj8nXxTmkRzHe/ziOrEm9dVRmbCL5c3OX6Lwx6yoDcu
        NsUVy9OfHkHGinPcx2TjAH54hs7953nEubgRh9ttFyef81YV15O78uwBThAkRmb3UvZrvN
        bQaeaYVnJzEAkJnV/DFvlHYVbMvAeRI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 63986021 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 30 Dec 2021 14:34:36 +0000 (UTC)
Received: by mail-yb1-f181.google.com with SMTP id y130so48358463ybe.8;
        Thu, 30 Dec 2021 06:34:35 -0800 (PST)
X-Gm-Message-State: AOAM532qAApfdHqGALvUCNwCy9H6iL+zVwBvOL/JG2Q2JIZr6ftLlmys
        vilug4wWzH3fhnyEBJTm+rveg+qKcl+USRGvvcY=
X-Google-Smtp-Source: ABdhPJwpff3L/cBgBiiDcNjU/h+Qdpi2L5SYPv3RB8RPDE900c00T9n7OKHFblQ+DHpF3dVD22Ko7VasnaAF9YvYVgw=
X-Received: by 2002:a25:854f:: with SMTP id f15mr29073476ybn.121.1640874874920;
 Thu, 30 Dec 2021 06:34:34 -0800 (PST)
MIME-Version: 1.0
References: <20211228153826.448805-1-Jason@zx2c4.com> <20211229211009.108091-1-linux@dominikbrodowski.net>
 <20211229211009.108091-5-linux@dominikbrodowski.net>
In-Reply-To: <20211229211009.108091-5-linux@dominikbrodowski.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 30 Dec 2021 15:34:24 +0100
X-Gmail-Original-Message-ID: <CAHmME9q5_S-UQXKU9BDWdosEN_+neb_Eg6EfPkkN8PtN1Fvnbg@mail.gmail.com>
Message-ID: <CAHmME9q5_S-UQXKU9BDWdosEN_+neb_Eg6EfPkkN8PtN1Fvnbg@mail.gmail.com>
Subject: Re: [PATCH v8 5/7] random: harmonize "crng init done" messages
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "Ivan T . Ivanov" <iivanov@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Applied, thanks.
