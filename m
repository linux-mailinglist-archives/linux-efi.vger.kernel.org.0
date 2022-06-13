Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6726C547F7B
	for <lists+linux-efi@lfdr.de>; Mon, 13 Jun 2022 08:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233363AbiFMGZz (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 13 Jun 2022 02:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233335AbiFMGZy (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 13 Jun 2022 02:25:54 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C37CFC
        for <linux-efi@vger.kernel.org>; Sun, 12 Jun 2022 23:25:53 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id y187so4725428pgd.3
        for <linux-efi@vger.kernel.org>; Sun, 12 Jun 2022 23:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=kHvqhKfwkSYWgIBUppKUElAVHImwDcI/W0up7OF2SsA=;
        b=N9/7xWdL+HXkVKNIefr4jQkYWZnbgsjUNbgoLWMP4TCLxMIhGeUaY8X6T3BBP3Axqc
         gxQtgwfKmD1ejA90+u8othcUaq4bqsnIhcWOF2fo1TC+ewajCDy+jTRmCYcUifDAiBSX
         FoqCgTMER28/yETHsW++HS37kHkvwI9MBXK3UVHgNLMeGIIApwxt06CW1Cea3crebfWX
         liAszq8zCYTU0DbH/Y0WcZXj1BkCk84A1hqTt7Gd1hQSHR7kA6Jrhch0ms4AibRzZN1F
         5IebhWYoTll7oSPKFw4VC2JIVEZaIgIIBtvyneZrYwS/M9DNbFJPfmgRDtU1b1T9yJ5Y
         7nzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=kHvqhKfwkSYWgIBUppKUElAVHImwDcI/W0up7OF2SsA=;
        b=loKq53+Q6is4aBmCYMAvw48suJMAAkAauIcSputdM5mLmmQ1JeYbaFGwdOtw13TSVL
         AeOj8rt8RjANvG1DMraf7UD3WqTxDQAq61RpdA7llHLfvXq21EIqGY4HKbQgzzI3wHyp
         jWCr0Mis50g94Gd0koMiT6iTj4bols+iIx9s7fdx1OJ2zsTrPKyl8RzncJrPw87o3tCs
         S/jZ64hvltdWkGDW7zrymuIlKH7F16qE2IC+95MHETGWGS7t3GSf5Nl+eDHMS5IhJNZX
         JvzFQTxgYeqHEOShi0AOAFIt6OlKwp9R/g0So+2CA0fr8e1o2CogNjeyO/houe5vLJ0o
         d/Xg==
X-Gm-Message-State: AOAM532/Sj0A3xTKgBOquuYegBREHQ41cSHOuk8vg0+6oscSZBd60YLI
        OOv2plYUb24HDnvShXYZQabQxg1cqtY97Irzuw==
X-Google-Smtp-Source: ABdhPJz9dN8Mrj5SZvaZfuDsIYAAEBjxYZlMoCiHXKewSlf0Nbo1ZYb/1Xl4ZPoynFNiIbmYX0J3UmwUII8lJJhgKLU=
X-Received: by 2002:a63:4853:0:b0:3fa:dc6:7ac2 with SMTP id
 x19-20020a634853000000b003fa0dc67ac2mr50697028pgk.298.1655101552926; Sun, 12
 Jun 2022 23:25:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a20:d2c7:b0:84:398b:ef0b with HTTP; Sun, 12 Jun 2022
 23:25:52 -0700 (PDT)
Reply-To: peterwhite202101@gmail.com
From:   Peter White <petersamuel20118@gmail.com>
Date:   Mon, 13 Jun 2022 06:25:52 +0000
Message-ID: <CACU92gfcpxL-w0b0A8TZaNMRVMMXDAaAcCEnwbKZ7nd0aa9Cwg@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Greetings from here.

I want to know if this email address is still valid to write to you.
There is something important I would like to discuss with you.

Thank you

Mr. Peter White
