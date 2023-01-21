Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C79D8676678
	for <lists+linux-efi@lfdr.de>; Sat, 21 Jan 2023 14:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbjAUNX7 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 21 Jan 2023 08:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjAUNX6 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 21 Jan 2023 08:23:58 -0500
X-Greylist: delayed 137438 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 21 Jan 2023 05:23:56 PST
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5AC247080
        for <linux-efi@vger.kernel.org>; Sat, 21 Jan 2023 05:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1674307435;
        bh=oNO0kDi/Kl7A0aHfHHk2DyBUzv4WFniS3a76w22o4Do=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=IdZlxwqSLN45bbu9if1ZWB89HfLdX6Lk5qdIp670UdQb5QnwhXCybQOOEuwYliNqT
         Z1rG8nsxiRMVEhxGdAnqyk67U+mhfxf2kiVUcuhqfF5cScJCpEsE5j18MRr6tm6tOD
         c5rjG+VJc2sj1t2Fi/b4KloY2agEvU3ViTbSz0S4=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id F309E1286368;
        Sat, 21 Jan 2023 08:23:55 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XlEc4N3-5lcr; Sat, 21 Jan 2023 08:23:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1674307435;
        bh=oNO0kDi/Kl7A0aHfHHk2DyBUzv4WFniS3a76w22o4Do=;
        h=Message-ID:Subject:From:To:Date:In-Reply-To:References:From;
        b=IdZlxwqSLN45bbu9if1ZWB89HfLdX6Lk5qdIp670UdQb5QnwhXCybQOOEuwYliNqT
         Z1rG8nsxiRMVEhxGdAnqyk67U+mhfxf2kiVUcuhqfF5cScJCpEsE5j18MRr6tm6tOD
         c5rjG+VJc2sj1t2Fi/b4KloY2agEvU3ViTbSz0S4=
Received: from [IPv6:2601:5c4:4302:c21::a774] (unknown [IPv6:2601:5c4:4302:c21::a774])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 59DF41286364;
        Sat, 21 Jan 2023 08:23:55 -0500 (EST)
Message-ID: <e75c7d4be4cda26dc1e40a88e8de5cfa12810d3f.camel@HansenPartnership.com>
Subject: Re: Is there a known boot failure with 6.2-rc and the Intel SDV EFI
 systems?
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        linux-efi@vger.kernel.org
Date:   Sat, 21 Jan 2023 08:23:53 -0500
In-Reply-To: <0eabbe98-db6e-b5db-ca5b-3f212bf2f734@leemhuis.info>
References: <f2503170d12dc567c00998d4e72ba806f7677730.camel@HansenPartnership.com>
         <0eabbe98-db6e-b5db-ca5b-3f212bf2f734@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Sat, 2023-01-21 at 14:20 +0100, Linux kernel regression tracking
(#adding) wrote:
> [TLDR: I'm adding this report to the list of tracked Linux kernel
> regressions; the text you find below is based on a few templates
> paragraphs you might have encountered already in similar form.
> See link in footer if these mails annoy you.]

This isn't an EFI regression.  It actually bisects to an oops in one of
my modified TPM drivers which is being initialized early because of
IMA.  The problem is the EFI console isn't showing it, so I just get no
output after loading the initrd but, as far as I can tell, this is a
longstanding problem.

James

