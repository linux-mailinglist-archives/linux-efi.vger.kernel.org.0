Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D12872E1C7
	for <lists+linux-efi@lfdr.de>; Tue, 13 Jun 2023 13:36:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239456AbjFMLgS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 13 Jun 2023 07:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239396AbjFMLgR (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 13 Jun 2023 07:36:17 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F26D9D1
        for <linux-efi@vger.kernel.org>; Tue, 13 Jun 2023 04:36:15 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-970056276acso819140566b.2
        for <linux-efi@vger.kernel.org>; Tue, 13 Jun 2023 04:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686656174; x=1689248174;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aWPSS4nQP7w/sP247wDxABPZtjWV1EhZ4vjjjJ6SajI=;
        b=j/4PjbbH8jBLfmuke7PdKxifdkXtpIUZDqgqYr1SLtYQ80rCLF6uRmbv4qidNbQFeu
         YHnlO01+DLGzLl74nZGp42gRflO4pnQ+7WXgdeMmiUn7GKKf4dNhg5FIP624lBLEVexZ
         LmS+mbkQG8ntTOlU3yovDZmJkJF9Mr0ecK+glMYETSqKX77h6AteGmWj2fWIrtimV6YY
         EHRO1iQmNwwbpxM33+x5uYu/atdOYHIGg7DQQX0Qsffe31Z8ZQ+ekKkFUyprxY/JEICo
         4MuT0WoJTuZ3sHXNhCIHJeIonXzwN0OAdSZPCLDaCQtM7NNUsZ/bcz0DMaSQ/vQ7v2nh
         0ZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686656174; x=1689248174;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aWPSS4nQP7w/sP247wDxABPZtjWV1EhZ4vjjjJ6SajI=;
        b=JJTAyKfyYx+uU4HVyZrc6R3xoI2MIcxQZGl1zkHq2nAAkXdxDqNXPie0+thtJflrba
         Dzmu7RCRr2mEZSDH/mbJpfdgdxFnGalxeh+/RNFqgyS980rcBjd/NdIZXuTiLb78DirI
         8opwYDh6e/Rtfm+i5nRRp8qYlC3esXiTf5hQcuIBp+3a8/NBJiyPM/RwNvETfAHRXkEk
         I8opqcGYdih51PnYhVV5KKQ1oS3GD1UQ1SKPE1fi5z25hxMdCyvcE73LGnSOXNZS+RNc
         u0mZZvyU21r6xEwtCiAWBHjEXJoc6OlgnC1buJRq63tSBa3SP+V/kCQuOli2Pyd4c0f2
         Y47Q==
X-Gm-Message-State: AC+VfDz9G/U2CQKmhPdd33p5KH8lVUUQGWdzW5KJSfzyILwUZ4990ouT
        u0PymLQ63ZugGUuV548UZrU/V/W4vmZe6ba4BQ==
X-Google-Smtp-Source: ACHHUZ4FMP+J2aagmRuajsdLPRZ9sT22V6b+bHvwLFY0yMXMae6Pxb8y+PMLMRoDhRgQzFV8hBOIuL1pJH0obHNCNC4=
X-Received: by 2002:a17:906:fe43:b0:978:9235:d428 with SMTP id
 wz3-20020a170906fe4300b009789235d428mr11024662ejb.36.1686656174207; Tue, 13
 Jun 2023 04:36:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6f02:c084:b0:50:6ff5:d22c with HTTP; Tue, 13 Jun 2023
 04:36:13 -0700 (PDT)
Reply-To: francescogaetano01@outlook.com
From:   FRANCESCO GAETANO <reginakarugo1968@gmail.com>
Date:   Tue, 13 Jun 2023 14:36:13 +0300
Message-ID: <CA+cNoAjKqsGoAW35VEhOJB9xH59UEbvgeQT2wx9rWVAS9C9oGg@mail.gmail.com>
Subject: Rahaline annetus.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
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

--=20
Summa 1 000 000,00 =E2=82=AC annetas teile Francesco Gaetano Caltagirone.
Lisateabe saamiseks p=C3=B6=C3=B6rduge palun tagasi aadressil
francescogaetano01@outlook.com



The sum of =E2=82=AC1,000,000.00 has been donated to you by Francesco Gaeta=
no
Caltagirone, Kindly get back for more info via
francescogaetano01@outlook.com
