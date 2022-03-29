Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267ED4EB5C3
	for <lists+linux-efi@lfdr.de>; Wed, 30 Mar 2022 00:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236467AbiC2WUh (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 29 Mar 2022 18:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236228AbiC2WUh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 29 Mar 2022 18:20:37 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C8E44133F;
        Tue, 29 Mar 2022 15:18:53 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id b19so26728546wrh.11;
        Tue, 29 Mar 2022 15:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:mime-version:content-transfer-encoding
         :content-description:subject:to:from:date:reply-to;
        bh=+v//v9bV1cKxYYqp6E5HrJfuFydY/JXcjMGnmfr7lM0=;
        b=AaO/7U6voaQRExQlTqfDcA+oIsiwc81pgkEPkOsPtz85YHR368ABI46O2bkEjbJErR
         oUP8PByB4+6CWDngNCqOiNmAyfn6iMtxYx8fMg7Uge80694no39LhYQRgPcUY7M0G/7S
         e7QNxs3cy3xLLoRZn2KFLJHwKVv7Ii9z5EJ+FcPNu6kMrpEjqrVMuW+jgTogI7z/p4za
         QqfG/cn+0Kzj2SVdLnp9s/m+Oo0ph90ABQKB8hdEBJJ9torko0+CIDDJR8PZXgeVNfnY
         da9TcsyFdgmBUBzAXOa5J9FrdDAUt2wck2kBo81PqaTa6Xyqxuen4c4hNwnrmBKe9CtO
         /p6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:content-description:subject:to:from:date
         :reply-to;
        bh=+v//v9bV1cKxYYqp6E5HrJfuFydY/JXcjMGnmfr7lM0=;
        b=qso1w9T65yzhQH4SugwIXE0w/cscOacj7V6vybPzSvh3BPt2FZKK++XNLHLi+tRHaX
         Cm2HlCgItcgrA//cnkHUV2pMuJ/j/DO1XdFPBimuFTh6VD1RpONkk64/4lBJSPLSG6Vf
         LyLMlP73E1TZdzKG/ndTGAUr2JIJfvcQJjXrywNu5O9iPSwdNW5IT4083Qx/spAyPxqu
         5PqbS8qjK12E47zQ1rupZnXb3Mmxmmow8Bd3rDibQxEqCq6jwydWrVrjFB56XnK7GKTC
         EnalsLuuzjE9SM8kZcYgHB49AsWY9gPH9VhbBST2HzCNXYKrdTKBZ4fJfByabHyczGRD
         HMPA==
X-Gm-Message-State: AOAM532jR5l597Br7WiUwAPpBjEm+4TM5zt2r9l1a2ed/bxalZ6Nqu/r
        EcF7op2LehNxJdOh9hWTa2zOTM8Zl+xMqU2hCeI=
X-Google-Smtp-Source: ABdhPJw9q+xTJm9zRorIk40024hWICgfunfYZFNzzOl8F5eeT5uxdWelv06Bvoaz46ynlRPaBzlvjw==
X-Received: by 2002:a5d:640a:0:b0:204:619:4354 with SMTP id z10-20020a5d640a000000b0020406194354mr33632345wru.43.1648592331829;
        Tue, 29 Mar 2022 15:18:51 -0700 (PDT)
Received: from [172.20.10.4] ([197.210.71.189])
        by smtp.gmail.com with ESMTPSA id x3-20020a5d6b43000000b001e317fb86ecsm15642619wrw.57.2022.03.29.15.18.45
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 29 Mar 2022 15:18:50 -0700 (PDT)
Message-ID: <624385ca.1c69fb81.af85d.d5c0@mx.google.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Gefeliciteerd, er is geld aan je gedoneerd
To:     Recipients <adeboyejofolashade55@gmail.com>
From:   adeboyejofolashade55@gmail.com
Date:   Tue, 29 Mar 2022 23:18:37 +0100
Reply-To: mike.weirsky.foundation003@gmail.com
X-Spam-Status: No, score=2.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,T_US_DOLLARS_3
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Beste begunstigde,

 Je hebt een liefdadigheidsdonatie van ($ 10.000.000,00) van Mr. Mike Weirs=
ky, een winnaar van een powerball-jackpotloterij van $ 273 miljoen.  Ik don=
eer aan 5 willekeurige personen als je deze e-mail ontvangt, dan is je e-ma=
il geselecteerd na een spin-ball. Ik heb vrijwillig besloten om het bedrag =
van $ 10 miljoen USD aan jou te doneren als een van de geselecteerde 5, om =
mijn winst te verifi=EBren
 =

  Vriendelijk antwoord op: mike.weirsky.foundation003@gmail.com
 Voor uw claim.
