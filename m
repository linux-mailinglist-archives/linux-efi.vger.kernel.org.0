Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F36D165D337
	for <lists+linux-efi@lfdr.de>; Wed,  4 Jan 2023 13:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234986AbjADMyp (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Jan 2023 07:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233900AbjADMye (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Jan 2023 07:54:34 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BCC1CFDC
        for <linux-efi@vger.kernel.org>; Wed,  4 Jan 2023 04:54:32 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id c9so16214354qko.6
        for <linux-efi@vger.kernel.org>; Wed, 04 Jan 2023 04:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g2m/uNsCm/OsAUZxAnJOSdXXDa9Gh4wg88n4VPL2lMU=;
        b=WgtPiGBL7pKpeGAONT7jyOZBlPA87PF+BcZ0At3DRbjh8r4a90VkFTuegmf7v5I05U
         8O8yRsMlEC8d3azBuhTVnh5a19IMri1yaM5CNo7nGSQjhbPmAzApkJwS9Ixgc01L8XVA
         9+oXPryfLJjc92HnUP6sxIyah9VARXZTMfFxXMcqBFJ6snOmablGghR0F2+Y0sgoHgie
         QmoiaDCXomaXijXUVGiYmzsfSWGfWMMdh1Ev9V0gp78bfPbYO2S9uBzuU4GRDkm7vJO6
         RsJ5hkLkj5KAchsYozNwRuUxQUGpmscZ9Mbjv/HN5G//qfUumyrbxcj+0dSg+lcPq80U
         5Wuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g2m/uNsCm/OsAUZxAnJOSdXXDa9Gh4wg88n4VPL2lMU=;
        b=OIc8T+7FZzSuffyWDksNreiH4eOVxNlnKyFzp6bEPMWQirnhKY8HdYzo3yn/jmqnl6
         xvfdKrYqAPW15k5gMQUULzpPBup1Ttuf0oTXYrLP8NRZjv+LFcmXfJQ6TVMX7DUAipZ6
         7jgu3PojySDmINHDqqcDVxyyAwvuUckaRDu6V+0qLlLKEGjnAmSL9csZsDmEqXZNOgIp
         3Nu7ez87ioX3Nn6w3OvSqgyRQWvyFVvDrRfpvSiLu+NydnnXSbdGFPTWBtoUa1rZ/a7M
         PdGeA3gnDNAMQv8jVKkYVwgUYpuXgWiG4pdvaGZvznTkNgv63i6XT++xjzE2hjv3hIxi
         wVSw==
X-Gm-Message-State: AFqh2krakZi/pWHqxy29+KyOz3A6KA3CcJpXNkFtlETgUn6Mf6bMM4p+
        /uT6kwutqWoFbCJY0eqvZEpMn8uBd7dfSvaXRUE=
X-Google-Smtp-Source: AMrXdXulKMdRBV/p4kXNikXMHFtLk5IOIYLDRJA7lpoRUfUF8+2cEqH8pHXLi4qSeE4J34Id+Th3n/mMQjaZgJWZFyc=
X-Received: by 2002:a05:620a:8502:b0:704:ad9e:ad7 with SMTP id
 pe2-20020a05620a850200b00704ad9e0ad7mr1970941qkn.574.1672836871311; Wed, 04
 Jan 2023 04:54:31 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6200:5d91:b0:4a5:78e9:2012 with HTTP; Wed, 4 Jan 2023
 04:54:30 -0800 (PST)
Reply-To: Gregdenzell9@gmail.com
From:   Greg Denzell <mzsophie@gmail.com>
Date:   Wed, 4 Jan 2023 12:54:30 +0000
Message-ID: <CAEoj5=a-iCsZoe4s4S8=o2P=8nfbDVvG8sm_YZ9wpP37ZOqYKA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Seasons Greetings!

This will remind you again that I have not yet received your reply to
my last message to you.
