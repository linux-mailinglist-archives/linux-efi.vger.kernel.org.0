Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43204481D9E
	for <lists+linux-efi@lfdr.de>; Thu, 30 Dec 2021 16:12:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235945AbhL3PM4 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 30 Dec 2021 10:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235850AbhL3PM4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 30 Dec 2021 10:12:56 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2A74C061574;
        Thu, 30 Dec 2021 07:12:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1C605CE1C2D;
        Thu, 30 Dec 2021 15:12:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CACDC36AEF;
        Thu, 30 Dec 2021 15:12:51 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="icXtwm01"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1640877169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jyHdQprcy3Zdmaq6WsLYeA8Eb5yrd1cw20rhtg5CzBQ=;
        b=icXtwm017t9hoY1wGhL9ldIUw593kx4mOt1vJxgY5pAJ9F4vtuAFUlbldgJRgtsU2rsCjB
        HDujD+rXrXCtMXLb2irlMEcHhQVTjkOwzMOBhaUOpeDmDJGXmv2XlZCXH2InxySGAr/ZUU
        L1CHZr78cacqm0c5OZvuVxW42Odpbzk=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 6021b039 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Thu, 30 Dec 2021 15:12:49 +0000 (UTC)
Received: by mail-yb1-f178.google.com with SMTP id d201so49222614ybc.7;
        Thu, 30 Dec 2021 07:12:49 -0800 (PST)
X-Gm-Message-State: AOAM533VFjcBXrq2k/e2u38JshCa1kKVM8RbwhdiJugWqvNlaIlBhQE3
        TPFdmqvJ/p/SsjIBsSC/iPAtGUh1X1ezCqGg6vc=
X-Google-Smtp-Source: ABdhPJydstAGA4i+VYCy9w9tTLupmoKB1GF1VWlAGgk7NMwylb8ER/+Je5g1g2AlJd2mAGrLtUPWUD8GZOyhSa4vY/A=
X-Received: by 2002:a25:854f:: with SMTP id f15mr29273529ybn.121.1640877168229;
 Thu, 30 Dec 2021 07:12:48 -0800 (PST)
MIME-Version: 1.0
References: <20211228153826.448805-1-Jason@zx2c4.com> <20211229211009.108091-1-linux@dominikbrodowski.net>
 <20211229211009.108091-7-linux@dominikbrodowski.net> <Yc102b3gCiIjC88e@owl.dominikbrodowski.net>
In-Reply-To: <Yc102b3gCiIjC88e@owl.dominikbrodowski.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 30 Dec 2021 16:12:37 +0100
X-Gmail-Original-Message-ID: <CAHmME9ppDKOSMeMFjMr1XAt8_8kSSUpUWS1vL2yeZjb27=ePhw@mail.gmail.com>
Message-ID: <CAHmME9ppDKOSMeMFjMr1XAt8_8kSSUpUWS1vL2yeZjb27=ePhw@mail.gmail.com>
Subject: Re: [PATCH v8.1 7/7] random: move NUMA-related code to CONFIG_NUMA section
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        "Ivan T . Ivanov" <iivanov@suse.de>,
        Ard Biesheuvel <ardb@kernel.org>, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Rather than the fallout of this v8->v8.1 resulting in functions
needing to move around, I think it might actually be cleaner to do an
IS_ENABLED thing. I'll send a patch to this thread and you can tell me
what you think of that instead.

Jason
