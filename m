Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB23D639CA2
	for <lists+linux-efi@lfdr.de>; Sun, 27 Nov 2022 20:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbiK0TyV (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 27 Nov 2022 14:54:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbiK0TyT (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 27 Nov 2022 14:54:19 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34EDCDF52
        for <linux-efi@vger.kernel.org>; Sun, 27 Nov 2022 11:54:19 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id a11-20020a05600c2d4b00b003cf6f5fd9f1so7043563wmg.2
        for <linux-efi@vger.kernel.org>; Sun, 27 Nov 2022 11:54:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:mime-version:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=biw1utCmNyI+ef9futimPqL2qrgw3YwY9eWMD1oBQZg=;
        b=BpPpsStQBq8Gw8ILKAdqmVk1byyFbxcRxvX37/fjBYla9SQjJg83aEK6K9FqiyiN7s
         AUtzxjoysqh31Pz5AYZTmI4w8gZ0DNKO9Z+LhJDVdoSdc9EpN3pHt5SYhFiQdUJNTnn/
         0yVM5jadxUtUvdwaU2oJOI8unpGUHc4NgQJGqniKN/u15WXKPoZBGeD4QSqg2+c8tAkL
         513IquKzK4GrJ31kkMFwx/nO8Rak5dp1DsHuXoeQF3uo8kfx/6ipcrWTqDuQdDFq4TBz
         EGo03LlYYZE/feNSWg8KdxMfFYxKS2C2K/mJ0Xz+WsMaVn95C1cSZZOWHSTJNyanVgnr
         gQpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:mime-version:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=biw1utCmNyI+ef9futimPqL2qrgw3YwY9eWMD1oBQZg=;
        b=hqASVctsn2F0adRbwtQ7Twj2BLPw0wZudLxdOIsJN28DTikmAplt4N7s7gKESsqzbv
         FtgqW8oLnOLc0I+rw1nQeENBbRl8J98SgrFfG28D/YBWl74MzzkUJRwqhCgFcj4lWsFs
         +aVSjxLjdAe38QwnTIrerj8JtmJdGYOr0QMWskFUeYR2BjokUh7reqCVQcr/0M7dPkbL
         OCeRXVgiG1EYR3ZOycbqxf2TGbdlNDpqUD0mlaN3zhXbKYh6VUmm7cVSCgrJvAYCD5zq
         XaUKuSecmUM7OArVK+9yGAp2/XyKK1ddui+vaOG4InZSNd2Na7SmW4jCCHHxeEy3kSbA
         Cxzw==
X-Gm-Message-State: ANoB5pmbsFkr0fek8juQ94yP8qMuS/Fl7K8W8Ed8A7cjxjvCVB+KjZoE
        Hu8PBskmEDLX+hQSkXSUC5VsS5csiRg/xLA6yJGZVq3l6XnwSg6d
X-Google-Smtp-Source: AA0mqf4PA3DwOsxvZY8UI2bXaBmE4DjFn4VwgOpQQrzM3tzhT9M3q480KY9nmpj5eBB3BPgR7Cg2Fk7MH5GKp1Eqjh0=
X-Received: by 2002:a05:600c:4c96:b0:3cf:6a66:e324 with SMTP id
 g22-20020a05600c4c9600b003cf6a66e324mr27930690wmp.158.1669578857573; Sun, 27
 Nov 2022 11:54:17 -0800 (PST)
Received: from 332509754669 named unknown by gmailapi.google.com with
 HTTPREST; Sun, 27 Nov 2022 13:54:17 -0600
From:   HAROLD COOPER <haroldcooper810@gmail.com>
Mime-Version: 1.0
Date:   Sun, 27 Nov 2022 13:54:17 -0600
Message-ID: <CA+0JWirDDk6bf1h5YTagfWLvrY-mi2hMFrOvb+UwTB1-pbMuAA@mail.gmail.com>
Subject: HARD HAT
To:     linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.1 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

To whom it may concern,
I would like to order HARD HAT . I would be glad if you could email me
back with the types and pricing you carry at the moment .

Regards ,
Mr HAROLD COOPER
PH: 813 750 7707
