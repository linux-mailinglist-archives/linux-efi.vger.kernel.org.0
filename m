Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B7D6559AD
	for <lists+linux-efi@lfdr.de>; Sat, 24 Dec 2022 10:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiLXJeg (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sat, 24 Dec 2022 04:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiLXJee (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sat, 24 Dec 2022 04:34:34 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F57D11F;
        Sat, 24 Dec 2022 01:34:33 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id B578E343B2;
        Sat, 24 Dec 2022 09:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1671874471; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eE/z5WCQh56VYMVihL9wEIrUZUiMYWxUT4Dnqk8RnNY=;
        b=BIYDuvQNxxtJKMiynn1Tn5AFkiCbJ9vSdZ2bncGSxlRyiXHK9zdJlzpmDhamfEjfKejxHx
        Ay0gCbExsjrQY0aLvaRFom1Vs24OEtD3eNL3qZSL86UO2sf/GHdfzEWAIXhWM9eJxSQLcc
        jP5LqYdXExsMc+XXR1kaZGpllV9LqrM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1671874471;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=eE/z5WCQh56VYMVihL9wEIrUZUiMYWxUT4Dnqk8RnNY=;
        b=rGcff8MX9/EVUW9sQ1k/N2cL2PUGavK2QCP/Po47peLQ0QMesoZRxYy7oH8yDkOxDrFTvI
        cD63AiYNgsejGNAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 622A113918;
        Sat, 24 Dec 2022 09:34:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RsGdFqfHpmOhbQAAMHmgww
        (envelope-from <tzimmermann@suse.de>); Sat, 24 Dec 2022 09:34:31 +0000
Message-ID: <2761b1e1-508d-2c2c-f2d8-6f1be536723e@suse.de>
Date:   Sat, 24 Dec 2022 10:34:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 0/2] Recover from failure to probe GPU
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        linux-efi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org,
        Carlos Soriano Sanchez <csoriano@redhat.com>,
        christian.koenig@amd.com
References: <20221222183012.1046-1-mario.limonciello@amd.com>
Content-Language: en-US
From:   Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <20221222183012.1046-1-mario.limonciello@amd.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------EBfSh5xZlvVk5oLicG0xRk3V"
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,TRACKER_ID autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------EBfSh5xZlvVk5oLicG0xRk3V
Content-Type: multipart/mixed; boundary="------------IoFDFfc1IeNs80OXfId1EPOG";
 protected-headers="v1"
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Mario Limonciello <mario.limonciello@amd.com>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Alex Deucher <alexander.deucher@amd.com>, linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, Carlos Soriano Sanchez <csoriano@redhat.com>,
 christian.koenig@amd.com
Message-ID: <2761b1e1-508d-2c2c-f2d8-6f1be536723e@suse.de>
Subject: Re: [PATCH 0/2] Recover from failure to probe GPU
References: <20221222183012.1046-1-mario.limonciello@amd.com>
In-Reply-To: <20221222183012.1046-1-mario.limonciello@amd.com>

--------------IoFDFfc1IeNs80OXfId1EPOG
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkNCg0KQW0gMjIuMTIuMjIgdW0gMTk6MzAgc2NocmllYiBNYXJpbyBMaW1vbmNpZWxsbzoN
Cj4gT25lIG9mIHRoZSBmaXJzdCB0aGluZyB0aGF0IEtNUyBkcml2ZXJzIGRvIGR1cmluZyBp
bml0aWFsaXphdGlvbiBpcw0KPiBkZXN0cm95IHRoZSBzeXN0ZW0gZmlybXdhcmUgZnJhbWVi
dWZmZXIgYnkgbWVhbnMgb2YNCj4gYGRybV9hcGVydHVyZV9yZW1vdmVfY29uZmxpY3Rpbmdf
cGNpX2ZyYW1lYnVmZmVyc2ANCj4gDQo+IFRoaXMgbWVhbnMgdGhhdCBpZiBmb3IgYW55IHJl
YXNvbiB0aGUgR1BVIGZhaWxlZCB0byBwcm9iZSB0aGUgdXNlcg0KPiB3aWxsIGJlIHN0dWNr
IHdpdGggYXQgYmVzdCBhIHNjcmVlbiBmcm96ZW4gYXQgdGhlIGxhc3QgdGhpbmcgdGhhdA0K
PiB3YXMgc2hvd24gYmVmb3JlIHRoZSBLTVMgZHJpdmVyIGNvbnRpbnVlZCBpdCdzIHByb2Jl
Lg0KPiANCj4gVGhlIHByb2JsZW0gaXMgbW9zdCBwcm9ub3VuY2VkIHdoZW4gbmV3IEdQVSBz
dXBwb3J0IGlzIGludHJvZHVjZWQNCj4gYmVjYXVzZSB1c2VycyB3aWxsIG5lZWQgdG8gaGF2
ZSBhIHJlY2VudCBsaW51eC1maXJtd2FyZSBzbmFwc2hvdA0KPiBvbiB0aGVpciBzeXN0ZW0g
d2hlbiB0aGV5IGJvb3QgYSBrZXJuZWwgd2l0aCBtYXRjaGluZyBzdXBwb3J0Lg0KPiANCj4g
SG93ZXZlciB0aGUgcHJvYmxlbSBpcyBmdXJ0aGVyIGV4YWdnZXJhdGVkIGluIHRoZSBjYXNl
IG9mIGFtZGdwdSBiZWNhdXNlDQo+IGl0IGhhcyBtaWdyYXRlZCB0byAiSVAgZGlzY292ZXJ5
IiB3aGVyZSBhbWRncHUgd2lsbCBhdHRlbXB0IHRvIGxvYWQNCj4gb24gIkFMTCIgQU1EIEdQ
VXMgZXZlbiBpZiB0aGUgZHJpdmVyIGlzIG1pc3Npbmcgc3VwcG9ydCBmb3IgSVAgYmxvY2tz
DQo+IGNvbnRhaW5lZCBpbiB0aGF0IEdQVS4NCj4gDQo+IElQIGRpc2NvdmVyeSByZXF1aXJl
cyBzb21lIHByb2JpbmcgYW5kIGlzbid0IHJ1biB1bnRpbCBhZnRlciB0aGUNCj4gZnJhbWVi
dWZmZXIgaGFzIGJlZW4gZGVzdHJveWVkLg0KPiANCj4gVGhpcyBtZWFucyBhIHNpdHVhdGlv
biBjYW4gb2NjdXIgd2hlcmUgYSB1c2VyIHB1cmNoYXNlcyBhIG5ldyBHUFUgbm90DQo+IHll
dCBzdXBwb3J0ZWQgYnkgYSBkaXN0cmlidXRpb24gYW5kIHdoZW4gYm9vdGluZyB0aGUgaW5z
dGFsbGVyIGl0IHdpbGwNCj4gImZyZWV6ZSIgZXZlbiBpZiB0aGUgZGlzdHJpYnV0aW9uIGRv
ZXNuJ3QgaGF2ZSB0aGUgbWF0Y2hpbmcga2VybmVsIHN1cHBvcnQNCj4gZm9yIHRob3NlIElQ
IGJsb2Nrcy4NCj4gDQo+IFRoZSBwZXJmZWN0IGV4YW1wbGUgb2YgdGhpcyBpcyBVYnVudHUg
MjEuMTAgYW5kIHRoZSBuZXcgZEdQVXMganVzdA0KPiBsYXVuY2hlZCBieSBBTUQuICBUaGUg
aW5zdGFsbGF0aW9uIG1lZGlhIHNoaXBzIHdpdGgga2VybmVsIDUuMTkgKHdoaWNoDQo+IGhh
cyBJUCBkaXNjb3ZlcnkpIGJ1dCB0aGUgYW1kZ3B1IHN1cHBvcnQgZm9yIHRob3NlIElQIGJs
b2NrcyBsYW5kZWQgaW4NCj4ga2VybmVsIDYuMC4gVGhlIG1hdGNoaW5nIGxpbnV4LWZpcm13
YXJlIHdhcyByZWxlYXNlZCBhZnRlciAyMS4xMCdzIGxhdW5jaC4NCj4gVGhlIHNjcmVlbiB3
aWxsIGZyZWV6ZSB3aXRob3V0IG5vbW9kZXNldC4gRXZlbiBpZiBhIHVzZXIgbWFuYWdlcyB0
byBpbnN0YWxsDQo+IGFuZCB0aGVuIHVwZ3JhZGVzIHRvIGtlcm5lbCA2LjAgYWZ0ZXIgaW5z
dGFsbCB0aGV5J2xsIHN0aWxsIGhhdmUgdGhlDQo+IHByb2JsZW0gb2YgbWlzc2luZyBmaXJt
d2FyZSwgYW5kIHRoZSBzYW1lIGV4cGVyaWVuY2UuDQo+IA0KPiBUaGlzIGlzIHF1aXRlIGph
cnJpbmcgZm9yIHVzZXJzLCBwYXJ0aWN1bGFybHkgaWYgdGhleSBkb24ndCBrbm93DQo+IHRo
YXQgdGhleSBoYXZlIHRvIHVzZSAibm9tb2Rlc2V0IiB0byBpbnN0YWxsLg0KPiANCj4gVG8g
aGVscCB0aGUgc2l0dWF0aW9uLCBhbGxvdyBkcml2ZXJzIHRvIHJlLXJ1biB0aGUgaW5pdCBw
cm9jZXNzIGZvciB0aGUNCj4gZmlybXdhcmUgZnJhbWVidWZmZXIgZHVyaW5nIGEgZmFpbGVk
IHByb2JlLiBBcyB0aGlzIHByb2JsZW0gaXMgbW9zdA0KPiBwcm9ub3VuY2VkIHdpdGggYW1k
Z3B1LCB0aGlzIGlzIHRoZSBvbmx5IGRyaXZlciBjaGFuZ2VkLg0KPiANCj4gQnV0IGlmIHRo
aXMgbWFrZXMgc2Vuc2UgbW9yZSBnZW5lcmFsbHkgZm9yIG90aGVyIEtNUyBkcml2ZXJzLCB0
aGUgY2FsbA0KPiBjYW4gYmUgYWRkZWQgdG8gdGhlIGNsZWFudXAgcm91dGluZSBmb3IgdGhv
c2UgdG9vLg0KDQpKdXN0IGEgcXVpY2sgZHJpdmUtYnkgY29tbWVudDogYXMgSmF2aWVyIG5v
dGVkLCBhdCBzb21lIHBvaW50IHdoaWxlIA0KcHJvYmluZywgeW91ciBkcml2ZXIgaGFzIGNo
YW5nZWQgdGhlIGRldmljZScgc3RhdGUgYW5kIHRoZSBzeXN0ZW0gRkIgDQp3aWxsIGJlIGdv
bmUuIHlvdSBjYW5ub3QgcmVlc3RhYmxpc2ggdGhlIHN5c2ZiIGFmdGVyIHRoYXQuDQoNCllv
dSBhcmUsIGhvd2V2ZXIgZnJlZSB0byByZWFkIGRldmljZSBzdGF0ZSBhdCBhbnkgdGltZSwg
YXMgbG9uZyBhcyBpdCANCmhhcyBubyBzaWRlIGVmZmVjdHMuDQoNClNvIHdoeSBub3QganVz
dCBtb3ZlIHRoZSBjYWxsIHRvIA0KZHJtX2FwZXJ0dXJlX3JlbW92ZV9jb25mbGljdGluZ19w
Y2lfZnJhbWVidWZmZXJzKCkgdG8gYSBsYXRlciBwb2ludCB3aGVuIA0KeW91IGtub3cgdGhh
dCB5b3VyIGRyaXZlciBzdXBwb3J0cyB0aGUgaGFyZHdhcmU/IFRoYXQncyB0aGUgc29sdXRp
b24gd2UgDQphbHdheXMgcHJvcG9zZWQgdG8gdGhpcyBraW5kIG9mIHByb2JsZW0uIEl0J3Mg
c2FmZSBhbmQgd29uJ3QgcmVxdWlyZSBhbnkgDQpjaGFuZ2VzIHRvIHRoZSBhcGVydHVyZSBo
ZWxwZXJzLg0KDQpCZXN0IHJlZ2FyZHMNClRob21hcw0KDQo+IA0KPiBIZXJlIGlzIGEgc2Ft
cGxlIG9mIHdoYXQgaGFwcGVucyB3aXRoIG1pc3NpbmcgR1BVIGZpcm13YXJlIGFuZCB0aGlz
DQo+IHNlcmllczoNCj4gDQo+IFsgICAgNS45NTAwNTZdIGFtZGdwdSAwMDAwOjYzOjAwLjA6
IHZnYWFyYjogZGVhY3RpdmF0ZSB2Z2EgY29uc29sZQ0KPiBbICAgIDUuOTUwMTE0XSBhbWRn
cHUgMDAwMDo2MzowMC4wOiBlbmFibGluZyBkZXZpY2UgKDAwMDYgLT4gMDAwNykNCj4gWyAg
ICA1Ljk1MDg4M10gW2RybV0gaW5pdGlhbGl6aW5nIGtlcm5lbCBtb2Rlc2V0dGluZyAoWUVM
TE9XX0NBUlAgMHgxMDAyOjB4MTY4MSAweDE3QUE6MHgyMkYxIDB4RDIpLg0KPiBbICAgIDUu
OTUyOTU0XSBbZHJtXSByZWdpc3RlciBtbWlvIGJhc2U6IDB4QjBBMDAwMDANCj4gWyAgICA1
Ljk1Mjk1OF0gW2RybV0gcmVnaXN0ZXIgbW1pbyBzaXplOiA1MjQyODgNCj4gWyAgICA1Ljk1
NDYzM10gW2RybV0gYWRkIGlwIGJsb2NrIG51bWJlciAwIDxudl9jb21tb24+DQo+IFsgICAg
NS45NTQ2MzZdIFtkcm1dIGFkZCBpcCBibG9jayBudW1iZXIgMSA8Z21jX3YxMF8wPg0KPiBb
ICAgIDUuOTU0NjM3XSBbZHJtXSBhZGQgaXAgYmxvY2sgbnVtYmVyIDIgPG5hdmkxMF9paD4N
Cj4gWyAgICA1Ljk1NDYzOF0gW2RybV0gYWRkIGlwIGJsb2NrIG51bWJlciAzIDxwc3A+DQo+
IFsgICAgNS45NTQ2MzldIFtkcm1dIGFkZCBpcCBibG9jayBudW1iZXIgNCA8c211Pg0KPiBb
ICAgIDUuOTU0NjQxXSBbZHJtXSBhZGQgaXAgYmxvY2sgbnVtYmVyIDUgPGRtPg0KPiBbICAg
IDUuOTU0NjQyXSBbZHJtXSBhZGQgaXAgYmxvY2sgbnVtYmVyIDYgPGdmeF92MTBfMD4NCj4g
WyAgICA1Ljk1NDY0M10gW2RybV0gYWRkIGlwIGJsb2NrIG51bWJlciA3IDxzZG1hX3Y1XzI+
DQo+IFsgICAgNS45NTQ2NDRdIFtkcm1dIGFkZCBpcCBibG9jayBudW1iZXIgOCA8dmNuX3Yz
XzA+DQo+IFsgICAgNS45NTQ2NDVdIFtkcm1dIGFkZCBpcCBibG9jayBudW1iZXIgOSA8anBl
Z192M18wPg0KPiBbICAgIDUuOTU0NjYzXSBhbWRncHUgMDAwMDo2MzowMC4wOiBhbWRncHU6
IEZldGNoZWQgVkJJT1MgZnJvbSBWRkNUDQo+IFsgICAgNS45NTQ2NjZdIGFtZGdwdTogQVRP
TSBCSU9TOiAxMTMtUkVNQlJBTkRULVgzNw0KPiBbICAgIDUuOTU0Njc3XSBbZHJtXSBWQ04o
MCkgZGVjb2RlIGlzIGVuYWJsZWQgaW4gVk0gbW9kZQ0KPiBbICAgIDUuOTU0Njc4XSBbZHJt
XSBWQ04oMCkgZW5jb2RlIGlzIGVuYWJsZWQgaW4gVk0gbW9kZQ0KPiBbICAgIDUuOTU0Njgw
XSBbZHJtXSBKUEVHIGRlY29kZSBpcyBlbmFibGVkIGluIFZNIG1vZGUNCj4gWyAgICA1Ljk1
NDY4MV0gYW1kZ3B1IDAwMDA6NjM6MDAuMDogYW1kZ3B1OiBUcnVzdGVkIE1lbW9yeSBab25l
IChUTVopIGZlYXR1cmUgZGlzYWJsZWQgYXMgZXhwZXJpbWVudGFsIChkZWZhdWx0KQ0KPiBb
ICAgIDUuOTU0NjgzXSBhbWRncHUgMDAwMDo2MzowMC4wOiBhbWRncHU6IFBDSUUgYXRvbWlj
IG9wcyBpcyBub3Qgc3VwcG9ydGVkDQo+IFsgICAgNS45NTQ3MjRdIFtkcm1dIHZtIHNpemUg
aXMgMjYyMTQ0IEdCLCA0IGxldmVscywgYmxvY2sgc2l6ZSBpcyA5LWJpdCwgZnJhZ21lbnQg
c2l6ZSBpcyA5LWJpdA0KPiBbICAgIDUuOTU0NzMyXSBhbWRncHUgMDAwMDo2MzowMC4wOiBh
bWRncHU6IFZSQU06IDUxMk0gMHgwMDAwMDBGNDAwMDAwMDAwIC0gMHgwMDAwMDBGNDFGRkZG
RkZGICg1MTJNIHVzZWQpDQo+IFsgICAgNS45NTQ3MzVdIGFtZGdwdSAwMDAwOjYzOjAwLjA6
IGFtZGdwdTogR0FSVDogMTAyNE0gMHgwMDAwMDAwMDAwMDAwMDAwIC0gMHgwMDAwMDAwMDNG
RkZGRkZGDQo+IFsgICAgNS45NTQ3MzhdIGFtZGdwdSAwMDAwOjYzOjAwLjA6IGFtZGdwdTog
QUdQOiAyNjc0MTk2NDhNIDB4MDAwMDAwRjgwMDAwMDAwMCAtIDB4MDAwMEZGRkZGRkZGRkZG
Rg0KPiBbICAgIDUuOTU0NzQ3XSBbZHJtXSBEZXRlY3RlZCBWUkFNIFJBTT01MTJNLCBCQVI9
NTEyTQ0KPiBbICAgIDUuOTU0NzUwXSBbZHJtXSBSQU0gd2lkdGggMjU2Yml0cyBMUEREUjUN
Cj4gWyAgICA1Ljk1NDgzNF0gW2RybV0gYW1kZ3B1OiA1MTJNIG9mIFZSQU0gbWVtb3J5IHJl
YWR5DQo+IFsgICAgNS45NTQ4MzhdIFtkcm1dIGFtZGdwdTogMTU2ODBNIG9mIEdUVCBtZW1v
cnkgcmVhZHkuDQo+IFsgICAgNS45NTQ4NzNdIFtkcm1dIEdBUlQ6IG51bSBjcHUgcGFnZXMg
MjYyMTQ0LCBudW0gZ3B1IHBhZ2VzIDI2MjE0NA0KPiBbICAgIDUuOTU1MzMzXSBbZHJtXSBQ
Q0lFIEdBUlQgb2YgMTAyNE0gZW5hYmxlZCAodGFibGUgYXQgMHgwMDAwMDBGNDFGQzAwMDAw
KS4NCj4gWyAgICA1Ljk1NTUwMl0gYW1kZ3B1IDAwMDA6NjM6MDAuMDogRGlyZWN0IGZpcm13
YXJlIGxvYWQgZm9yIGFtZGdwdS95ZWxsb3dfY2FycF90b2MuYmluIGZhaWxlZCB3aXRoIGVy
cm9yIC0yDQo+IFsgICAgNS45NTU1MDVdIGFtZGdwdSAwMDAwOjYzOjAwLjA6IGFtZGdwdTog
ZmFpbCB0byByZXF1ZXN0L3ZhbGlkYXRlIHRvYyBtaWNyb2NvZGUNCj4gWyAgICA1Ljk1NTUx
MF0gW2RybTpwc3Bfc3dfaW5pdCBbYW1kZ3B1XV0gKkVSUk9SKiBGYWlsZWQgdG8gbG9hZCBw
c3AgZmlybXdhcmUhDQo+IFsgICAgNS45NTU3MjVdIFtkcm06YW1kZ3B1X2RldmljZV9pbml0
LmNvbGQgW2FtZGdwdV1dICpFUlJPUiogc3dfaW5pdCBvZiBJUCBibG9jayA8cHNwPiBmYWls
ZWQgLTINCj4gWyAgICA1Ljk1NTk1Ml0gYW1kZ3B1IDAwMDA6NjM6MDAuMDogYW1kZ3B1OiBh
bWRncHVfZGV2aWNlX2lwX2luaXQgZmFpbGVkDQo+IFsgICAgNS45NTU5NTRdIGFtZGdwdSAw
MDAwOjYzOjAwLjA6IGFtZGdwdTogRmF0YWwgZXJyb3IgZHVyaW5nIEdQVSBpbml0DQo+IFsg
ICAgNS45NTU5NTddIGFtZGdwdSAwMDAwOjYzOjAwLjA6IGFtZGdwdTogYW1kZ3B1OiBmaW5p
c2hpbmcgZGV2aWNlLg0KPiBbICAgIDUuOTcxMTYyXSBlZmlmYjogcHJvYmluZyBmb3IgZWZp
ZmINCj4gWyAgICA1Ljk3MTI4MV0gZWZpZmI6IHNob3dpbmcgYm9vdCBncmFwaGljcw0KPiBb
ICAgIDUuOTc0ODAzXSBlZmlmYjogZnJhbWVidWZmZXIgYXQgMHg5MTAwMDAwMDAsIHVzaW5n
IDIwMjUyaywgdG90YWwgMjAyNTBrDQo+IFsgICAgNS45NzQ4MDVdIGVmaWZiOiBtb2RlIGlz
IDI4ODB4MTgwMHgzMiwgbGluZWxlbmd0aD0xMTUyMCwgcGFnZXM9MQ0KPiBbICAgIDUuOTc0
ODA3XSBlZmlmYjogc2Nyb2xsaW5nOiByZWRyYXcNCj4gWyAgICA1Ljk3NDgwN10gZWZpZmI6
IFRydWVjb2xvcjogc2l6ZT04Ojg6ODo4LCBzaGlmdD0yNDoxNjo4OjANCj4gWyAgICA1Ljk3
NDk3NF0gQ29uc29sZTogc3dpdGNoaW5nIHRvIGNvbG91ciBmcmFtZSBidWZmZXIgZGV2aWNl
IDE4MHg1Ng0KPiBbICAgIDUuOTc4MTgxXSBmYjA6IEVGSSBWR0EgZnJhbWUgYnVmZmVyIGRl
dmljZQ0KPiBbICAgIDUuOTc4MTk5XSBhbWRncHU6IHByb2JlIG9mIDAwMDA6NjM6MDAuMCBm
YWlsZWQgd2l0aCBlcnJvciAtMg0KPiBbICAgIDUuOTc4Mjg1XSBbZHJtXSBhbWRncHU6IHR0
bSBmaW5hbGl6ZWQNCj4gDQo+IE5vdyBpZiB0aGUgdXNlciBsb2FkcyB0aGUgZmlybXdhcmUg
aW50byB0aGUgc3lzdGVtIHRoZXkgY2FuIHJlLWxvYWQgdGhlDQo+IGRyaXZlciBvciByZS1h
dHRhY2ggdXNpbmcgc3lzZnMgYW5kIGl0IGdyYWNlZnVsbHkgcmVjb3ZlcnMuDQo+IA0KPiBb
ICA2NjUuMDgwNDgwXSBbZHJtXSBJbml0aWFsaXplZCBhbWRncHUgMy40OS4wIDIwMTUwMTAx
IGZvciAwMDAwOjYzOjAwLjAgb24gbWlub3IgMA0KPiBbICA2NjUuMDkwMDc1XSBmYmNvbjog
YW1kZ3B1ZHJtZmIgKGZiMCkgaXMgcHJpbWFyeSBkZXZpY2UNCj4gWyAgNjY1LjA5MDI0OF0g
W2RybV0gRFNDIHByZWNvbXB1dGUgaXMgbm90IG5lZWRlZC4NCj4gDQo+IE1hcmlvIExpbW9u
Y2llbGxvICgyKToNCj4gICAgZmlybXdhcmU6IHN5c2ZiOiBBbGxvdyByZS1jcmVhdGluZyBz
eXN0ZW0gZnJhbWVidWZmZXIgYWZ0ZXIgaW5pdA0KPiAgICBkcm0vYW1kOiBSZS1jcmVhdGUg
ZmlybXdhcmUgZnJhbWVidWZmZXIgb24gZmFpbHVyZSB0byBwcm9iZQ0KPiANCj4gICBkcml2
ZXJzL2Zpcm13YXJlL2VmaS9zeXNmYl9lZmkuYyAgICAgICAgfCAgNiArKystLS0NCj4gICBk
cml2ZXJzL2Zpcm13YXJlL3N5c2ZiLmMgICAgICAgICAgICAgICAgfCAxNSArKysrKysrKysr
KysrKy0NCj4gICBkcml2ZXJzL2Zpcm13YXJlL3N5c2ZiX3NpbXBsZWZiLmMgICAgICAgfCAg
NCArKy0tDQo+ICAgZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYW1kZ3B1X2Rydi5jIHwg
IDIgKysNCj4gICBpbmNsdWRlL2xpbnV4L3N5c2ZiLmggICAgICAgICAgICAgICAgICAgfCAg
NSArKysrKw0KPiAgIDUgZmlsZXMgY2hhbmdlZCwgMjYgaW5zZXJ0aW9ucygrKSwgNiBkZWxl
dGlvbnMoLSkNCj4gDQo+IA0KPiBiYXNlLWNvbW1pdDogODMwYjNjNjhjMWZiMWU5MTc2MDI4
ZDAyZWY4NmYzY2Y3NmFhMjQ3Ng0KDQotLSANClRob21hcyBaaW1tZXJtYW5uDQpHcmFwaGlj
cyBEcml2ZXIgRGV2ZWxvcGVyDQpTVVNFIFNvZnR3YXJlIFNvbHV0aW9ucyBHZXJtYW55IEdt
YkgNCk1heGZlbGRzdHIuIDUsIDkwNDA5IE7DvHJuYmVyZywgR2VybWFueQ0KKEhSQiAzNjgw
OSwgQUcgTsO8cm5iZXJnKQ0KR2VzY2jDpGZ0c2bDvGhyZXI6IEl2byBUb3Rldg0K

--------------IoFDFfc1IeNs80OXfId1EPOG--

--------------EBfSh5xZlvVk5oLicG0xRk3V
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEExndm/fpuMUdwYFFolh/E3EQov+AFAmOmx6YFAwAAAAAACgkQlh/E3EQov+DL
zA//U3jSF1Bwn/4YzveKhiHzqWGivgSyMsFLXoqHLHi8QBWFhO23B54gCuD4nDAMnxanos0QJAaA
b51Xa+qjQ7/ujEhWg57g2SrS/UdxE/Oxipr4PUVF9bvbXnSgi4kHvySDQIs41dESLwGrf6zURkcb
r42GIQUhCE5alc00ON0ENACcRLWY1d/Zaix32PfYPFyREyZOUBs1mxeBEM3iu2z0hOqDJBB2yuKf
yObCB3qRTYUZAfddGIKFkKjx+ucXgpbFgPu2hGaBXk1w9Q38PTBuQJz9CLRV3Cz0kem2xhIve5ot
wRktx5hCjSH9hChfo3reC0Ew40ixJ5OM8wbt5aB5/XcWenPoZEiqsYEpaHBGZjPFbhDw8L0BMOwf
JiHXzjrc6IEzJtLxj7nCdOkcYmA7U6TuuMDng3Qji74WDmQWgHxQlLthhvy8FbRc2de9V+94SnFd
9iGu/bDi3ovClgyRVuIWXb1n1oVFpQ+n/j76rVaZHN+n/SHJi5CZJ7wa4WtG+p1w2GD53O3g4ofN
gokpgRBvEIMgTx0xmZjEbZftiJdx8IDux+Ag84/jIPjXFAh4P61NYKoFMpZuLsLEkFzyTS7AueX5
DVUwHFCN8w1lEfzPSPyJGwohFqzIlVqdItRAUy4Ugv9r+xvF4sCbW3wBNmEfTOi+BMB64obFqJj6
1Fs=
=kQXN
-----END PGP SIGNATURE-----

--------------EBfSh5xZlvVk5oLicG0xRk3V--
