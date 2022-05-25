Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D46534415
	for <lists+linux-efi@lfdr.de>; Wed, 25 May 2022 21:16:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344048AbiEYTQS (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 25 May 2022 15:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344829AbiEYTPV (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 25 May 2022 15:15:21 -0400
Received: from mail-vk1-xa2b.google.com (mail-vk1-xa2b.google.com [IPv6:2607:f8b0:4864:20::a2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B2ABAB
        for <linux-efi@vger.kernel.org>; Wed, 25 May 2022 12:15:15 -0700 (PDT)
Received: by mail-vk1-xa2b.google.com with SMTP id m203so10316899vke.13
        for <linux-efi@vger.kernel.org>; Wed, 25 May 2022 12:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=V3ilouT9genmWgVMdUNI5P/LrIsW5jIirCBfI8vk+4c=;
        b=VNL84agSPUNMz5ZHn5hB8GKcuYXWF3UmMPWc7Bb+LTV1k24f+olrtYnNlECI/5grU/
         gJfb9UnvXZhJDQqxsv/dzXgW1bjbq6IyojfmDsYouIZcF/WLojUh+pm2fw627QIhk2g/
         McEXiBrW7myNWu/lTrZvV8JW18fcv6SsDZ/36tX/pTSJWvCIFih0lZxPpUgHRWNLrUle
         p51+K/qbZ2PDQN0m49bSNWKknBDBPc4o0UNjJrkblUW7AxjIR7wXBWHyN8I3iTp4HVMq
         y0q/tTDGDPnjhRXcTELUkXzKa/fVcyoZ9W4DIAPSTdDiTGXbXBGKFL0k9dTRI7X3nIhl
         +vlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=V3ilouT9genmWgVMdUNI5P/LrIsW5jIirCBfI8vk+4c=;
        b=V6ehyhiCGbs3ogo82el/Bh/MQrWuQKEk20uucW/xoYZaIcpPpS2SCRToIhENsvz/9C
         fJoHL4efODPNJ0CF/ZR2+0vchN510jBxtrzFHhcYZN+8YoelbSI9ZcDCY7cfYc5+lczv
         1SBXzBliIJS55w7VP/m0/tIlM+9GW29LWpijun71k6CgsyQym5OPUq78wxg5IV9lna4c
         jhlfsz+a6ulXVBrdzf6g3qZEHGjYdXmpqpcCcRCExFWtO/XBKhmOHqJFQaThflL2Mdhr
         Ls3lkKAJXv5uMppJglbEGMPFBHJyw7iZVeBvBajLt7ct0i+pMz9hTxVgz+3hmkhNfFl0
         HPiw==
X-Gm-Message-State: AOAM532ZSLgOt28GSOyqwZ4wKiQtwHKv61qUl2UNiS6SIEM0PIAcO3KU
        XWHOtXgnSa0GKqUfroMc2WJMGXeoXYdjuHtCaG8=
X-Google-Smtp-Source: ABdhPJxvbXspaz4zW4ghROwe7mtZm5WXla6DcckQd/HYDwGnn3YvHT4Qg0k+dKQaME7SWYaZN0WbIPCLHXqJnnpri0k=
X-Received: by 2002:a05:6122:2228:b0:32d:e4e:a79a with SMTP id
 bb40-20020a056122222800b0032d0e4ea79amr12275696vkb.27.1653506113167; Wed, 25
 May 2022 12:15:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:d484:0:b0:2bc:cae4:6d22 with HTTP; Wed, 25 May 2022
 12:15:12 -0700 (PDT)
From:   Rolf Benra <olfbenra@gmail.com>
Date:   Wed, 25 May 2022 21:15:12 +0200
Message-ID: <CA+z==VuwuBBVBk+=-U0t779uO36bFwSsYR6Qwgz2z9Wbkk3iGw@mail.gmail.com>
Subject: Bitte kontaktaufnahme Erforderlich !!! Please Contact Required !!!
To:     contact@firstdiamondbk.com
Cc:     info@firstdiamondbk.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Guten Tag,

Ich habe mich nur gefragt, ob Sie meine vorherige E-Mail bekommen

haben ?

Ich habe versucht, Sie per E-Mail zu erreichen.

Kommen Sie bitte schnell zu mir zur=C3=BCck, es ist sehr wichtig.

Danke

Rolf Benra

olfbenra@gmail.com







----------------------------------




Good Afternoon,

I was just wondering if you got my Previous E-mail
have ?

I tried to reach you by E-mail.

Please come back to me quickly, it is very Important.

Thanks

Rolf Benra

olfbenra@gmail.com
