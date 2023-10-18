Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19047CE740
	for <lists+linux-efi@lfdr.de>; Wed, 18 Oct 2023 20:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjJRS4Z (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 18 Oct 2023 14:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJRS4Z (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 18 Oct 2023 14:56:25 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF83B124
        for <linux-efi@vger.kernel.org>; Wed, 18 Oct 2023 11:56:23 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d9c2420e417so3266168276.2
        for <linux-efi@vger.kernel.org>; Wed, 18 Oct 2023 11:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697655383; x=1698260183; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8u57CE8Kdi0g3jbFeaVMUNjtuMyTsXSOw82lfN+HY7s=;
        b=apfYQDO5wmiW21pRZhB2L1vOJ9K1ywL1K6UWrUJF/fNyLCBNKN1yR5zWDJTR009T5d
         N8k3xtIPzv/Mt3xpbL75R/eMqJsArfcSs4M7Yhzb1TJh9etxKWCyzkPsqhfkyIMntmnl
         k1WdQqR6EaEv7+W+gzlCmfidSA+7w4Pjym41VfRnmDlWFYKOMLL0Ip0YM65SEFQg0vrT
         AO7MZG1CNL5Kd0luhKmoV6PpQWfNdWuEVWLpo0505rxGPdqVy8vqLDnPQu7JYkO58haN
         OFpZ/TOR76guYxBhBzS1hZtvEaftPJ8agInMuX0hAZwENTZW8ID/BT96YyOsmBzbsySj
         OBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697655383; x=1698260183;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8u57CE8Kdi0g3jbFeaVMUNjtuMyTsXSOw82lfN+HY7s=;
        b=CCLR2u83ydwHBcrrpD029I20m7wHQzSTEr69Ck+U2tE9wZzF//tHo65fUWdYOUQ43K
         HSfNvIZg4lnhV+TFT7gvq1QcqF+dChBPscUVDzFRGcAm9XP/FE1EcQkTpWPPgfuTgNLA
         MP0afmcJkL7EHnlG3KOvGZcDphOclo/rP+UgJliz53GhphrMT9frF7PDDumScEyMfSds
         tZufHJ3wB2x8O4+TseAfrxXYrY1K9s5dEzdei2pmIeQ08oR3MUwi4xJhsUZWR5s50YX4
         EG+nBQq8NGfi8dDdGFtpGQX9dPt6oFW471Rnb4ZXs+4ZdpTfO/xT+KPZnfEsqql+xaw6
         1+kg==
X-Gm-Message-State: AOJu0Yx5jvMF46QSzzRwoSE1r7A2TC3pDzMhCjobJgor/4MmQAiDCn+y
        TK8P/b6smMNtsoxlbrxuIPg1MelS5XfV84jzj0MxCw==
X-Google-Smtp-Source: AGHT+IEVthnA6CU9mpkTsCHlLVMIzAPKmS4ZaPXH4ULIXiZ+5TAJwScCOKMTezMaxNwS+k8Jz117dmhU1EvVRABxWDU=
X-Received: by 2002:a25:b7cf:0:b0:d9a:d895:2ede with SMTP id
 u15-20020a25b7cf000000b00d9ad8952edemr238953ybj.16.1697655382857; Wed, 18 Oct
 2023 11:56:22 -0700 (PDT)
MIME-Version: 1.0
From:   Jianxiong Gao <jxgao@google.com>
Date:   Wed, 18 Oct 2023 11:56:10 -0700
Message-ID: <CAMGD6P3szwE-ji3sJsow5PPuazqQjQhgN4ZKFmUmZJ0Gfz=ByA@mail.gmail.com>
Subject: Re: [PATCHv2] efi/unaccepted: Fix soft lockups caused by parallel
 memory acceptance
To:     michael.roth@amd.com
Cc:     aarcange@redhat.com, ak@linux.intel.com, akpm@linux-foundation.org,
        ardb@kernel.org, bp@alien8.de, dave.hansen@intel.com,
        david@redhat.com, dfaggioli@suse.com, jroedel@suse.de,
        kirill.shutemov@linux.intel.com, linux-coco@lists.linux.dev,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, luto@kernel.org,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        mgorman@techsingularity.net, mingo@redhat.com,
        nik.borisov@suse.com, pbonzini@redhat.com, peterx@redhat.com,
        peterz@infradead.org, philip.cox@canonical.com,
        David Rientjes <rientjes@google.com>, rppt@kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        Sean Christopherson <seanjc@google.com>, stable@kernel.org,
        tglx@linutronix.de, thomas.lendacky@amd.com,
        tim.gardner@canonical.com, vbabka@suse.cz, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The patch helps us gain more stability in our testing.
We are not able to reproduce the soft lockup issue in over 20 runs
with 176 vcpus so far.

Thanks!
-- 
Jianxiong Gao
