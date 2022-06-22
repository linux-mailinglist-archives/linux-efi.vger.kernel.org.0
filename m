Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E235554E45
	for <lists+linux-efi@lfdr.de>; Wed, 22 Jun 2022 17:03:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358952AbiFVPDo (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 22 Jun 2022 11:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358881AbiFVPDn (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 22 Jun 2022 11:03:43 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7165A3983F
        for <linux-efi@vger.kernel.org>; Wed, 22 Jun 2022 08:03:41 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id t3-20020a17090a510300b001ea87ef9a3dso17065739pjh.4
        for <linux-efi@vger.kernel.org>; Wed, 22 Jun 2022 08:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=vhZEVnaGNBjosB86GDUW8b2wHjB/+QU31bPXl36TqFE=;
        b=lmXhPRDXrnlbYClAFJkfHZYdowqXsf1nTuDLZnU/Y1W/T6TJ8ApbIv950i47frAtN/
         OtndHJQoWJG+weygm2GuosJduERMEzUHLtTF4oGKopzqXa+c5O1ob2p5JuwuGNaCZz0D
         0k2iO6ZG6gpeVsjTt5A+NLMvCH8qDkpG8Ex3xIMBpunG6BNJWrlCGLJYo7boJK6pvBIx
         W4x550ST0gVpK9sdxwL58OfMVVl7H7xG/39bSvJCxipLUGbdwSBY6WRzvY6hd28wfB/N
         vDKUfqITg8PxsgA4g6gEDGmS0K0dBg3KSntFmGDvcmLKkvSy/F4e+TYysqkO/txSQBCJ
         afFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=vhZEVnaGNBjosB86GDUW8b2wHjB/+QU31bPXl36TqFE=;
        b=lMtmzDMobK9+Mucric0y//Kn8V8pfkfOqhdxsU8O9UpB6CRvBHmKmYhb8Bll+AC9gW
         tiCYkH4wmgFIeYIDVw1cqpTrJ/DTrYF256CJcq6Wse6RCaiLXZLQl8kzx15OrxR/IUWQ
         5G62/1bGxfXgFF57eGE1+/a7pF+bVPQgMlVorrTNvOtwLMQ8RjGIPNjRgzpXnbqRrVmu
         5IUfihOhLYMilzq0N9jcMjhNBM+gHHZjLdFDQtqE/hapPe2OaEEEqPUwMu4ndnSVGjk2
         Y5N9+kS7s0v5D3k/OOs+JI4DDvXkq28rypWmCmsoJxAoDstqY5X5pZMtZvgrMLk7pc5D
         uPSg==
X-Gm-Message-State: AJIora/HYmF6VO40l6RF6w3qqgNRBPsHZoKvIa8Ktz0yxVfxmsdkh+EG
        vOoDwFNs5qELwrld/kfwKtS9T2akE+93AvXHV9Y=
X-Google-Smtp-Source: AGRyM1ulxotWsDV/SS5wzW6q4zt5LXu3F658bS4StYWI/FgPuIBqBz38zqk7aydOTm9FXxU+wDfnf428k+eRTEG/aD8=
X-Received: by 2002:a17:90b:1988:b0:1ec:f52d:90d4 with SMTP id
 mv8-20020a17090b198800b001ecf52d90d4mr1796737pjb.70.1655910220864; Wed, 22
 Jun 2022 08:03:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:903:2308:b0:16a:1b3f:f74b with HTTP; Wed, 22 Jun 2022
 08:03:40 -0700 (PDT)
Reply-To: sales0212@asonmedsystemsinc.com
From:   Prasad Ronni <lerwickfinance7@gmail.com>
Date:   Wed, 22 Jun 2022 16:03:40 +0100
Message-ID: <CAFkto5vTxj70kORZJZdwOGowXjsZ399eo6DJj=8T==7paSuHTw@mail.gmail.com>
Subject: Service Needed.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

-- 
Hi,

Are you currently open to work as our executive company representative
on contractual basis working remotely? If yes, we will be happy to
share more details. Looking forward to your response.

Regards,
