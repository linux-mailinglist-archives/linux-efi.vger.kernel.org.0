Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08D856953C
	for <lists+linux-efi@lfdr.de>; Thu,  7 Jul 2022 00:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbiGFWXd (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 6 Jul 2022 18:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233982AbiGFWXb (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 6 Jul 2022 18:23:31 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FDF8286CE
        for <linux-efi@vger.kernel.org>; Wed,  6 Jul 2022 15:23:30 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id o185so4048428vsc.7
        for <linux-efi@vger.kernel.org>; Wed, 06 Jul 2022 15:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=LIYkXsh8NuZ+kWZJQV6Z3UgDflGRM7baotKUMbx/XVo=;
        b=QbbAwt/DxM1yoKPvRyHt+JT+N/1xxROTMO1V6M25+Rkkpsp+SkEVK78kVVnZwKbp4e
         QxJUwxMU2qXoE2amjVupHkBXtfSwR+oXIVRT8rSioEVxun130eNSK2YbuRUAIkF54f3v
         lpY5McuyK8+dnAWNbrjfu1LS5TDLuOI7cHvRcO7hoMhLqIKhASGPt9QY9EYf13lGjv1U
         0R7BLeg4iUl0OSqLmrNltL4fHeW99ymZL+9QS2fv3Zl5VT2gT7DkxQdteu3ijYk3HfrT
         E6ju4GFGM2F20NZauQuNbA904uXZZykoLavPdccMcRpkqsKPpDAGLnsC0hYRotgoULt3
         ENCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=LIYkXsh8NuZ+kWZJQV6Z3UgDflGRM7baotKUMbx/XVo=;
        b=dyvGnUFZUBKy5v4aTbirHlwDF5vjUv5Ru4rhCpuILTcXL2f33UCmMlG3QKtyN2pJ9n
         npHEGaKnU9yb4BmHQLGug/MxAR/h4Qg1CIAAqdTzUT+4XArQ/MgUOhugrJhz5xw5g9gh
         CCRxMVbmd6rlMbOqSmVWHki9v7vLipvO66/L7V1oxOxwCxHdi8wqYAo/j8eo5NNqaBbA
         ZhMGXdIMtyCgQOPQsLkRFviVRm+JYm2vUcZgysEMIaqbndhCiwHo01UmivIztWbhNcxI
         VUOFlhs8kj35XmgepYhB+OB0jof0TxmmGsipfzry1HEwxOd4vQJ16ObuJL2HgaCjti0t
         jiXA==
X-Gm-Message-State: AJIora9U3Q3xVrVoQacmV+XS7VTjkyo8kjiCVWI6yXss5zyqqIqd35t4
        g3YKr3Rre26UEFc6jI5mMRqMvHB9wYfzXrHKMj0=
X-Google-Smtp-Source: AGRyM1vNqOAB/A4b2lZcgIposTMhspjC8U8NPfbud9pbELKkszlrPyxDMVeAVv3tD3YPsKovgpYf/iwZ8Uj0PFX2T2A=
X-Received: by 2002:a67:d616:0:b0:356:ffd9:588c with SMTP id
 n22-20020a67d616000000b00356ffd9588cmr5765646vsj.63.1657146209002; Wed, 06
 Jul 2022 15:23:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:9fc7:0:b0:2ca:d188:e802 with HTTP; Wed, 6 Jul 2022
 15:23:28 -0700 (PDT)
Reply-To: te463602@gmail.com
From:   "Mr. KAbore Aouessian" <kiboraouessian@gmail.com>
Date:   Wed, 6 Jul 2022 15:23:28 -0700
Message-ID: <CALGXYcS-4ZpPkWaHaE1RkZMeAHprbO7mTcSsA=iC1u2wugjQ=w@mail.gmail.com>
Subject: Greetings,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

-- 
Greetings,
I'm Mr. KAbore Aouessian, how are you doing hope you are in good
health, the Board irector try to reach you on phone several times
Meanwhile, your number was not connecting. before he ask me to send
you an email to hear from you if you are fine. hope to hear you are in
good Health.

Thanks,
Mr. KAbore Aouessian.
