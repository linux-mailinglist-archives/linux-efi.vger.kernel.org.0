Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53F64BE776
	for <lists+linux-efi@lfdr.de>; Mon, 21 Feb 2022 19:03:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358756AbiBUNPt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 21 Feb 2022 08:15:49 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358737AbiBUNPs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 21 Feb 2022 08:15:48 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147651EECE
        for <linux-efi@vger.kernel.org>; Mon, 21 Feb 2022 05:15:25 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id p9so26990568wra.12
        for <linux-efi@vger.kernel.org>; Mon, 21 Feb 2022 05:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=FyG0ATSkb5fmrso4VuDc0KiEUJrvvMWML2pstdAYUxY=;
        b=idntWtAKFEO/YVc6i1eFf332nYQeo62iuyg7SSBsClCMXapSXqwAoN4J8LAtIADN1f
         eHh8qyfPDSLfQLz50fTLBmbOrCitMZbvJNpm85atWfFGlVgOt0KTHP1b/pMC38GOrXeQ
         apwpi/3e9gRTS1gEiRRGkPRTqSJXhfHdK95iy996vias25lQFgeVYOP5NPhFvBpoVo1a
         LJYpQ6M9H1NVJjgKGK/hpxenppyIaieAVxueZZ2YOED4BQv/1cimMXj6q9ZLjz2PAEER
         SBpPIcgmRuYqcWqDeed+yv+PG/NjvrNFDAu5sjkWljsqO1EYPIpgsDL9GsDSQYLFJtLT
         n9UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=FyG0ATSkb5fmrso4VuDc0KiEUJrvvMWML2pstdAYUxY=;
        b=zDxsALg8PTyA48fcbIZ96dgv+m2w2ufo/fCyFybnDsosEuKam3nbYPwk+bdjsjgbge
         H9/PIl4BRbnW1iv/f5fNuACQmy5rnapgKIla/1CBeFfEr5LOuypcnThKmAs3dn8q0amK
         DsGYEU9rcYiCDjCqCyDJaA1fKR3yT4oDAx9NnNZoragiHQANwBabJWuu2cBqIksv7G8T
         QX7Fc5t32aR8EBfIBPbUr14bCLH51kyCQrNgW0oSvFXFxjsJFJKzW1oyUA3ut4wPA4f8
         bwfJtTFCSDOvdIIK9kNpQaMeVEyUpJJEkxzrg7X68lz8F9CnNGwk353xSisQyyO9le5h
         Qg7A==
X-Gm-Message-State: AOAM532uBLllWVHMww5TsEbYPfkU+bcs+qCrxzaUbSbRftUKMXH8P7Vw
        AvYyMDsJHFOSuZfTu6hniRU=
X-Google-Smtp-Source: ABdhPJyG6RNrdlHxdnKCoban5c3z5Og0ArIPqGyWfAlkw5jgz92a9HHxrUCYLoaZus3hPdZtMpREeA==
X-Received: by 2002:adf:c509:0:b0:1e3:f23:5bb2 with SMTP id q9-20020adfc509000000b001e30f235bb2mr15038229wrf.157.1645449323713;
        Mon, 21 Feb 2022 05:15:23 -0800 (PST)
Received: from [192.168.0.133] ([5.193.8.34])
        by smtp.gmail.com with ESMTPSA id m13-20020a05600c3b0d00b0037c00e01771sm7717377wms.34.2022.02.21.05.15.20
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 21 Feb 2022 05:15:23 -0800 (PST)
Message-ID: <6213906b.1c69fb81.f921d.9a47@mx.google.com>
From:   Mrs Maria Elisabeth Schaeffler <briankevin154@gmail.com>
X-Google-Original-From: Mrs Maria Elisabeth Schaeffler
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Spende
To:     Recipients <Mrs@vger.kernel.org>
Date:   Mon, 21 Feb 2022 17:15:16 +0400
Reply-To: mariaeisaeth001@gmail.com
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,TO_MALFORMED,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hallo,

Ich bin Frau Maria Elisabeth Schaeffler, eine deutsche Wirtschaftsmagnatin,=
 Investorin und Philanthropin. Ich bin der Vorsitzende von Wipro Limited. I=
ch habe 25 Prozent meines pers=F6nlichen Verm=F6gens f=FCr wohlt=E4tige Zwe=
cke ausgegeben. Und ich habe auch versprochen zu geben
der Rest von 25% geht dieses Jahr 2021 an Einzelpersonen. Ich habe mich ent=
schlossen, Ihnen 1.500.000,00 Euro zu spenden. Wenn Sie an meiner Spende in=
teressiert sind, kontaktieren Sie mich f=FCr weitere Informationen.

Sie k=F6nnen auch =FCber den untenstehenden Link mehr =FCber mich lesen


https://en.wikipedia.org/wiki/Maria-Elisabeth_Schaeffler

Sch=F6ne Gr=FC=DFe
Gesch=E4ftsf=FChrer Wipro Limited
Maria-Elisabeth_Schaeffler
Email: mariaeisaeth001@gmail.com=20
