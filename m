Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935A54E3C43
	for <lists+linux-efi@lfdr.de>; Tue, 22 Mar 2022 11:14:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232845AbiCVKPj (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 22 Mar 2022 06:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232888AbiCVKPh (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 22 Mar 2022 06:15:37 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE32624F13
        for <linux-efi@vger.kernel.org>; Tue, 22 Mar 2022 03:14:08 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id bg31-20020a05600c3c9f00b00381590dbb33so1099817wmb.3
        for <linux-efi@vger.kernel.org>; Tue, 22 Mar 2022 03:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:mime-version:content-transfer-encoding
         :content-description:subject:to:from:date:reply-to;
        bh=Pm04dP0+P83KVn44y+vrJDsQ3iwP6pKc5n+Js9E3oKk=;
        b=GCTX9xrjUml1V2UEK3vQNpt542VIjvufPnW3pI0IAZLHxB/mYSK/j7T2Milh05xDlh
         DgvEqyQCP1YJgtsqvy7BW2ryFFdvplO3JO8dR4EA59SXVsBsMyxqSkXMx9qcOjfJlZ8C
         GxEw/vCPAk7TegP298/ulbMrpW35oVbockPneJ6f5lD/CySyUiS81bXa5vnsLf/+dLIY
         OiX9x9MYchmPofCSdD8O1RnFpYDdJ1Ivxq7/JAm+c6o4q9UD1ZmHpfnQPwn3YZI9MoUz
         ABsss7kt+gO0uAL2fE2GsTQ6Lz90wLH0PuGfjDv5X119RQKH/jljqf2hf571BbnS+mJA
         um5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:content-description:subject:to:from:date
         :reply-to;
        bh=Pm04dP0+P83KVn44y+vrJDsQ3iwP6pKc5n+Js9E3oKk=;
        b=hKKjzIbufqyPxp7UfKW01YHdVFDpPw0s/t46TEhM7asKHNESHIXXVRWDOQ8ZLSx+B+
         ZJwgPW3A/rtoFkMnUor84qfnMEhxLpvVpXvrz5/rON+eMbPBYTLsgKrS9D4UmpP4Tzzz
         0hm46vcSdj8FQKSnocf1BbKYWVQzLheY+H6A2R89RMIAXkiT3B86yEB3XbJ1RbWrWwL+
         pWUNf9uyyX/LuCztuqE3Fwa1evBXBgNIlnpA35/3TUTBNOLSD0uHdJDxCoEwd6Qtr2Ri
         1KuHo17IylYiabLicbDbY+o7QNRWFlM/zay266uZDoPUCLWwX2HlJTgpJ0hgRiZ84t0L
         u8dw==
X-Gm-Message-State: AOAM530ROM5KPYYb50KUg3BvCmGUj3gusd7WXs9v9onZQHdyNCFu49a7
        KaHscmea8cofb5vN1e2w4j8=
X-Google-Smtp-Source: ABdhPJzf38hqLEdX/M2VvTUxJdgVrgqr4QzPvHOOeaXyg5478cYm8Oy8AF4gMcGVNjVWvha1jK5owg==
X-Received: by 2002:a7b:c30a:0:b0:389:9e1e:a15f with SMTP id k10-20020a7bc30a000000b003899e1ea15fmr3018620wmj.28.1647944047432;
        Tue, 22 Mar 2022 03:14:07 -0700 (PDT)
Received: from [192.168.43.30] ([197.211.61.62])
        by smtp.gmail.com with ESMTPSA id e8-20020a056000178800b00203da3bb4d2sm16280021wrg.41.2022.03.22.03.14.02
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 22 Mar 2022 03:14:06 -0700 (PDT)
Message-ID: <6239a16e.1c69fb81.e69e1.e7ca@mx.google.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: meine Spende
To:     kehindeomowumi974@gmail.com
From:   kehindeomowumi974@gmail.com
Date:   Tue, 22 Mar 2022 03:13:55 -0700
Reply-To: mariaelisabethschaeffler70@gmail.com
X-Spam-Status: No, score=3.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

 Hallo,

Ich bin Frau Maria Elisabeth Schaeffler, eine deutsche Gesch=E4ftsmagnatin,=
 Investorin und Philanthropin. Ich bin der Vorsitzende von Wipro Limited. I=
ch habe 25 Prozent meines pers=F6nlichen Verm=F6gens f=FCr wohlt=E4tige Zwe=
cke ausgegeben. Und ich habe auch versprochen, den Rest von 25% in diesem J=
ahr 2021 an Einzelpersonen zu verschenken. Ich habe beschlossen, Ihnen 1.50=
0.000,00 Euro zu spenden. Wenn Sie an meiner Spende interessiert sind, kont=
aktieren Sie mich f=FCr weitere Informationen.


Sie k=F6nnen auch mehr =FCber mich =FCber den unten stehenden Link lesen

https://en.wikipedia.org/wiki/Maria-Elisabeth_Schaeffler

Sch=F6ne Gr=FC=DFe

Gesch=E4ftsf=FChrer Wipro Limited

Maria Elisabeth Schaeffler

E-Mail: mariaelisabethschaeffler70@gmail.com
