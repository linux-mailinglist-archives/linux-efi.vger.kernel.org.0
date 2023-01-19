Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2929967470C
	for <lists+linux-efi@lfdr.de>; Fri, 20 Jan 2023 00:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjASXPc (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 19 Jan 2023 18:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjASXO4 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 19 Jan 2023 18:14:56 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EFC0171B
        for <linux-efi@vger.kernel.org>; Thu, 19 Jan 2023 15:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1674169996;
        bh=nsmESZtNpNvf1tlaxfGa0MvdhO+CFEWXvIpBA37hJA8=;
        h=Message-ID:Subject:From:To:Date:From;
        b=SxPj/0ele+F+UW0n3M02WYq4Ou7bxzB4WvKre0l/AfzMb7zX+q+twZyaSo8dLFiEi
         dwAP/3i0NQwezXOb+gutb0QabyUQo9H3+USLymnMAtjMJZeZLgnjo00zpzKiTZMXwK
         s4hDj5hA0K1PkOmiWPUpQbidEtYUQpo9dE8hW6tA=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id D0FED1280A87
        for <linux-efi@vger.kernel.org>; Thu, 19 Jan 2023 18:13:16 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MJnlTrYdmWpE for <linux-efi@vger.kernel.org>;
        Thu, 19 Jan 2023 18:13:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1674169996;
        bh=nsmESZtNpNvf1tlaxfGa0MvdhO+CFEWXvIpBA37hJA8=;
        h=Message-ID:Subject:From:To:Date:From;
        b=SxPj/0ele+F+UW0n3M02WYq4Ou7bxzB4WvKre0l/AfzMb7zX+q+twZyaSo8dLFiEi
         dwAP/3i0NQwezXOb+gutb0QabyUQo9H3+USLymnMAtjMJZeZLgnjo00zpzKiTZMXwK
         s4hDj5hA0K1PkOmiWPUpQbidEtYUQpo9dE8hW6tA=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 66F231280452
        for <linux-efi@vger.kernel.org>; Thu, 19 Jan 2023 18:13:16 -0500 (EST)
Message-ID: <f2503170d12dc567c00998d4e72ba806f7677730.camel@HansenPartnership.com>
Subject: Is there a known boot failure with 6.2-rc and the Intel SDV EFI
 systems?
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-efi@vger.kernel.org
Date:   Thu, 19 Jan 2023 18:13:14 -0500
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

I've got a Rainbow Bridge SDV I mostly use for TPM work, and I haven't
updated it in a while.  Today I found that the recent 6.2-rc4 kernel
won't boot and won't emit any kernel messages signalling a failure
somewhere in the handoff code.  I did put some EFI boot stub prints in
and verified it gets all the way to exit_boot_services before the
problem, so it smells like it fails initializing the EFI console for
runtime.  I've also verified that v6.1 release works just fine, so it
looks like something that went into EFI in the recent merge window. 
I'm starting to bisect now, but thought I'd ask in case anyone else has
already debugged this.

James

