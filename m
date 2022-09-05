Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D8365AD249
	for <lists+linux-efi@lfdr.de>; Mon,  5 Sep 2022 14:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236946AbiIEMWU (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 5 Sep 2022 08:22:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235598AbiIEMWT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 5 Sep 2022 08:22:19 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA064B0FE
        for <linux-efi@vger.kernel.org>; Mon,  5 Sep 2022 05:22:18 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id g7so12857719lfe.11
        for <linux-efi@vger.kernel.org>; Mon, 05 Sep 2022 05:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date;
        bh=AVzlpOVMlL3PDhtnJEoMKztQOh6SS46a/0M6oJWg4Ro=;
        b=qsed2gizbtRkp8bXghvmZpV5ts+uh2V66Tpv44HGdspYHJwBZ+lE55PgDi6TzGJ2z4
         qUTUCpw0EEnBdXPqvssRvPvcn4W2XQlvXeRVZ5GszGCirPPD51k3dh/hg/Q/UcX9BQNU
         K/eUkbdbeG68oBOxPzvRSwHFodzd0D9asTu8Q9O/ouU5Gg+aGgRBjutRKOVZX4dbF3/3
         z8yqBRrfKU9O/4eom8ZQzjJDKrNpZxNAlhB6+TyGxxXaLXis8Mi2zNisl6F3pSuTOU1X
         1aGdoFF3c1mJWKw9II/cafZBNTGF6Ust0uq3lY1+pEITdbzAhzEzv+JfxczyuSPjGhKj
         rx0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=AVzlpOVMlL3PDhtnJEoMKztQOh6SS46a/0M6oJWg4Ro=;
        b=ZRER9b62I2+nh0NCuhPZRK1PV+BCDxDazglKINQEUEkww91mRsLHZllqtK8c1GKQfg
         O8zli3oyh6u4iOX6sxilLrWCgq2z4nQmt/QwL3iqfxIekBWoU4twJ+YufEvDGcSqAHjz
         CUvkve0PcEC1WjMVCeIO7pYVMn/Waztg1iWeFVdybbxQEmL6aMUSdrE0+ScoOQYCUBUK
         0beJwnE8ndTINy+qATkwqvc4byxOdI5xdU5kpvmunpXkP3TFV97SAEUfxVswVWauQAqE
         +EI6mOnm9Fv2lBbSnzehsSI4irTm+BiwwgtIB5Of8cfcyFEHGJGxSFGCS5pqLzvSMYQ4
         93mQ==
X-Gm-Message-State: ACgBeo32A0UaoITb+BEU7Yo4Z9BCkDxpOzjUTR/MfVrA6xqyQ8zDzOJ5
        egogdFVAn3xNcC5wppX6W6//HmqrT40iZEWHpQw=
X-Google-Smtp-Source: AA6agR5wi/cGMMiXEZnxu7Blxs5fR+gSxarmriRbZn9PFUSBwgxe4HNiWSTshpoPLevQYrFkf95K6YON6hFFEZQlyRw=
X-Received: by 2002:a05:6512:1322:b0:492:de5b:dc3c with SMTP id
 x34-20020a056512132200b00492de5bdc3cmr15592792lfu.503.1662380536697; Mon, 05
 Sep 2022 05:22:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:651c:c9b:0:0:0:0 with HTTP; Mon, 5 Sep 2022 05:22:15
 -0700 (PDT)
Reply-To: golsonfinancial@gmail.com
From:   OLSON FINANCIAL GROUP <ogundarepamilerin12@gmail.com>
Date:   Mon, 5 Sep 2022 05:22:15 -0700
Message-ID: <CANKKXdJJ6SKGKL6nbuOpZXtdkMMeqnqZO13AJ9qYVV-bqmwj4g@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

--=20
h Gr=C3=BC=C3=9Fe,
Ben=C3=B6tigen Sie dringend einen Kredit, um ein Haus oder ein Unternehmen
zu kaufen? oder ben=C3=B6tigen Sie ein Gesch=C3=A4fts- oder Privatdarlehen,=
 um
zu investieren? ein neues Gesch=C3=A4ft er=C3=B6ffnen, Rechnungen bezahlen?=
 Und
zahlen Sie uns Installationen zur=C3=BCck? Wir sind ein zertifiziertes
Finanzunternehmen. Wir bieten Privatpersonen und Unternehmen Kredite
an. Wir bieten zuverl=C3=A4ssige Kredite zu einem sehr niedrigen Zinssatz
von 2 %. F=C3=BCr weitere Informationen
mailen Sie uns an: golsonfinancial@gmail.com....
