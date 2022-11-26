Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDCE163966F
	for <lists+linux-efi@lfdr.de>; Sat, 26 Nov 2022 15:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiKZO2l (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 26 Nov 2022 09:28:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiKZO2j (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 26 Nov 2022 09:28:39 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D621B9FD
        for <linux-efi@vger.kernel.org>; Sat, 26 Nov 2022 06:28:38 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id q12so2398417pfn.10
        for <linux-efi@vger.kernel.org>; Sat, 26 Nov 2022 06:28:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CYQnkZLU5iUF1wjk+/uD1OxI0fAg5dQVxpqvo7Cg/8Y=;
        b=Jeftu0PEa8p0U4L8PL/PcQB5zbFttnCogc6bYq6j1De/2sfQ6fVJXZrxcBpvEvW9ve
         AarXIj9EVdouL3QdX3plIam6UNnoAs8pVJ65PS/u5Z2wdPMm5BMeS3e+PlAZO9Tgjk+A
         06c1wPTfAlXvIDepFKPYhRsU/jycQZtDHNnLHjZKBlLFteJGY9hwkJqUsjZApYCxdltt
         CxL51zLx2yOGb9OZc07qoztlIHubtEtt09sSTGNHOBY7H3+aNoql3/nYFSyYOfmOnUZV
         ZSa9yc9jwmNqv2n7ngKLz4/bawgOzlT+fCQsb1KP1tvlRAPd37NNIQIPTVtK9T+W88mA
         rmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CYQnkZLU5iUF1wjk+/uD1OxI0fAg5dQVxpqvo7Cg/8Y=;
        b=Of+0BbvFAXOvoWCETfgl9d0arqVLUYQ+h5bE8jzUluqLtrT7yulA/fCPAjq0/rbA9/
         wDrAYdWVy/aPMODSj6VQUqNJLGnSyNKxWF3m0s+G6OjDp92TZqKA94HqB3aaYSz5DM22
         2aQ6GxBfRz3V+XbTmDTxq6DugMenXuQoqvU9PnLMGvN0JUmF8dV9FK9B/9r2KVz3AopJ
         WBexZ4RDIb8A1d8JEu7lv3y2o2IjtYtTBFLDdTD5YXUanY/m6hXw+qavMhUPEGMHhU+S
         htzSUBYrvDOAjER3yowyhDDOJellsRHkYGP085pnqe2J96pNho2ytxfhWdHDvtzqF9p5
         oB8Q==
X-Gm-Message-State: ANoB5pl+0y10qQ5IRJtNAcJpekc/+luQxin/aviEVRqPlw912Hg2uqpk
        15QKiiPVVP50HJBbCJKNMbcMjB9aSFV+xPNQbjI=
X-Google-Smtp-Source: AA0mqf50m86u8SMQoKWX9v/Zd92zdcBmpoAKvMGGSCKiuIb27ktE+pegbn2uZf9Hv+huccKxBV9w/34U9XY0I2CZUUc=
X-Received: by 2002:a63:4b0f:0:b0:439:3b80:615d with SMTP id
 y15-20020a634b0f000000b004393b80615dmr20654364pga.255.1669472917233; Sat, 26
 Nov 2022 06:28:37 -0800 (PST)
MIME-Version: 1.0
Sender: dr.alitrouni@gmail.com
Received: by 2002:a05:6a10:674e:b0:35b:aa43:3ec9 with HTTP; Sat, 26 Nov 2022
 06:28:36 -0800 (PST)
From:   AISHA GADDAFI <madamisha00@gmail.com>
Date:   Sat, 26 Nov 2022 15:28:36 +0100
X-Google-Sender-Auth: AIaGqoWhV_6CAvRHF9HtzpwHkzU
Message-ID: <CAE+xecAhLMsDDf7PEE9PR98H=rN2JwO0OL6kbDnNTdJHKSf8Ww@mail.gmail.com>
Subject: My name is Mrs. Aisha gaddafi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=3.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

esta es la Dra. Aisha al-Gaddafi, me comunico con usted porque necesito un
Socio o inversionista Que me ayudara a invertir la suma de $27.5
MillionUSD en su o
su pa=C3=ADs? Los fondos est=C3=A1n depositados en Burkina Faso, pero estoy=
 viviendo
en Om=C3=A1n para
el momento con mis hijos, intenta responderme lo antes posible, as=C3=AD
que dar=C3=A9 m=C3=A1s detalles, Dra. Aisha al-gaddafi.
