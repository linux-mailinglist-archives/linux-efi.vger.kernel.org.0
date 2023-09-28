Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A2867B1FEA
	for <lists+linux-efi@lfdr.de>; Thu, 28 Sep 2023 16:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbjI1OoD (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 28 Sep 2023 10:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbjI1OoC (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 28 Sep 2023 10:44:02 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB724180;
        Thu, 28 Sep 2023 07:44:00 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id DDC0240E0176;
        Thu, 28 Sep 2023 14:43:55 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OWLQHTNbZWTX; Thu, 28 Sep 2023 14:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1695912233; bh=h1/LDhE8fzT9yHzOAMn/O1uQcjI/GQRZwIc2SRP75FA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iZ5FRVunRWlEOnzVstKpLgxo9Pq1pLk58HzP++2IaqcTwzO8HrerFTvz+m0xvvPbA
         /1OYLbkPTP8O7vAFVM23V3gaF/swxmTcjRGRnDzcX6HKQ60eDJ9lFFmZx8SRyOwt4a
         gyyNnqRe+YgkZsoj+PJlVyCRJfSQBhxg8htG0sPi4XPKyx6hQkP8dikTsmct2e3Ifl
         UJ5PpeYWN6IbaMlFA2mv5N6SgFZhyMzBJOB702tLvbSQLn0+99W7IZfuPRozvWtxmP
         coGgcLA/k7hwojbNnq9oxY6uYA5481XGe2E0cDYK3VIVADW0p6WyVfAX8HuIcB+I2U
         OUTKPKDwtS5d8g/bLwq4yVYAm7OcT+lIFK1fKgmdggeKQqkNdKeDSu+7hSork76W1n
         B0xOU/+he+a/RqX6UyQyMS+kkfkQx7hIGxIeBZ9YgP8M1qEZJBd6Kl00RhuQRUBFV5
         wx2Ec8ZQlHwYd/MA6hQ5QH8u/cCNug+w7aFQVWzPunz/Ay7xqRMpbM+b4qRSHZmN+k
         RQig38hcXZ1IoLJa5xR1LXPxDFLcz61ZMbVx2/vem56E/luM49qcnwJQ5n6AMVJm2L
         xOIu9TAw8C3ZOTYf4EpvJUp2GAXG7WSB1O0j8IKufzGudrIurXHvYjx4Iijzna35tD
         I9qe4vVT+23x0C4PkzqztaUA=
Received: from nazgul.tnic (unknown [88.128.88.93])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4AD0D40E00B3;
        Thu, 28 Sep 2023 14:43:32 +0000 (UTC)
Date:   Thu, 28 Sep 2023 16:43:45 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     keescook@chromium.org, tony.luck@intel.com, gpiccoli@igalia.com,
        rafael@kernel.org, lenb@kernel.org, james.morse@arm.com,
        tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, ardb@kernel.org,
        robert.moore@intel.com, linux-hardening@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-efi@vger.kernel.org,
        acpica-devel@lists.linuxfoundation.org,
        baolin.wang@linux.alibaba.com
Subject: Re: [RFC PATCH v2 0/9] Use ERST for persistent storage of MCE and
 APEI errors
Message-ID: <20230928144345.GAZRWRIXH1Tfgn5EpO@fat_crate.local>
References: <20230925074426.97856-1-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230925074426.97856-1-xueshuai@linux.alibaba.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, Sep 25, 2023 at 03:44:17PM +0800, Shuai Xue wrote:
> After /dev/mcelog character device deprecated by commit 5de97c9f6d85
> ("x86/mce: Factor out and deprecate the /dev/mcelog driver"), the
> serialized MCE error record, of previous boot in persistent storage is not
> collected via APEI ERST.

You lost me here. /dev/mcelog is deprecated but you can still use it and
apei_write_mce() still happens.

Looking at your patches, you're adding this to ghes so how about you sit
down first and explain your exact use case and what exactly you wanna
do?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
